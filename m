Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A800416A97D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 16:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbgBXPLX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 10:11:23 -0500
Received: from mail-pl1-f179.google.com ([209.85.214.179]:41360 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbgBXPLX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 10:11:23 -0500
Received: by mail-pl1-f179.google.com with SMTP id t14so4168214plr.8;
        Mon, 24 Feb 2020 07:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:in-reply-to:references:mime-version:content-id
         :content-transfer-encoding:date:message-id;
        bh=Kzc9ux39Od3dwEalnzWN0BH2YsLE8P2IWylypPICc+Y=;
        b=jV9cAqJ807/qZDHwxvOMYuOXtd9OmLTvH7Af1NeJgWkFtzY8V+O1w3jG5R2uVp0CQx
         LYv2uetHMUXaENFm7seJBMbAVd5vUfaHC8FRvS+2FNjBDMefjkgdPCWmMB3pvyanOFZR
         kFcoPjRlkUejglOzjXJCpdiTp4amneDZD/dg45R6JAkk4Nl1s3lkjU83azcPPb/ZKuLT
         PVS4x2nM/JT17S1eVLvdd1CiR0V0SIX9Hqmxrl1WVMoY0y5zv1RpmNYN2B3xKU5PREil
         E4vZ7Q6+/mxDvzNguCaAN2UbHFAkoAWlZjzQrDbnlJUTT/PCBNJ4uZYlaPsaYAwy/v/I
         RtNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:in-reply-to:references
         :mime-version:content-id:content-transfer-encoding:date:message-id;
        bh=Kzc9ux39Od3dwEalnzWN0BH2YsLE8P2IWylypPICc+Y=;
        b=bJK9nvoftZq9e7WcGY/SzcyG/aceblMDQwUNiP8eyaXzeop+ZaTvRFB1rtDjyPpYNx
         kRZJEZZAq+u0yBO6Wk+PxDJfTeMJlVmjL/J3GLIddekb0VVSRAmNOBaN+Ga/eiC+rRTx
         2p77sxzdmpnK1doUxRcUNWDANhxENOd5giyzbLLT7OHU3p4xAekewMctq66RsF9CfDLW
         6pUkGo7dBFTMHc11sUlnMQnmLUaQc+rA5KItmN7m9ervWaLQ3vZtYIPIjIP/w0NohXLu
         7JHllANl8d9+bpUdb3XTKBw6xQhAaI1PZvVQPWMOa9DBYyMP11PO9lnXrIebHVJOnLPT
         tU+w==
X-Gm-Message-State: APjAAAW8Q7pgThvLLKR9WYfL+Yf4uBgL10VuIIflu2iEhpA6lpEsW5iC
        LHBpBo8u+8/zBAV2YtJaqFg=
X-Google-Smtp-Source: APXvYqy9T3AoG58bbmY/71DZUy0tJEFFAjeRoEvtoP6X1fYQj4JGoEMkYhXSLvp/tQ5PoObN78wn+w==
X-Received: by 2002:a17:90a:c705:: with SMTP id o5mr20518415pjt.67.1582557082290;
        Mon, 24 Feb 2020 07:11:22 -0800 (PST)
Received: from jromail.nowhere (h219-110-108-104.catv02.itscom.jp. [219.110.108.104])
        by smtp.gmail.com with ESMTPSA id d3sm12996713pfn.113.2020.02.24.07.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 07:11:21 -0800 (PST)
Received: from localhost ([127.0.0.1] helo=jrobl) by jrobl id 1j6FOC-0002gc-2w ; Tue, 25 Feb 2020 00:11:20 +0900
From:   "J. R. Okajima" <hooanon05g@gmail.com>
Subject: Re: ext2, possible circular locking dependency detected
To:     Jan Kara <jack@suse.cz>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
In-Reply-To: <20200224130219.GE27857@quack2.suse.cz>
References: <4946.1582339996@jrobl> <20200224090846.GB27857@quack2.suse.cz> <24689.1582538536@jrobl> <20200224130219.GE27857@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <10328.1582557080.1@jrobl>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 25 Feb 2020 00:11:20 +0900
Message-ID: <10329.1582557080@jrobl>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan Kara:
> OK, in the end I've decided to go with a different solution because I
> realized the warning is a false positive one. The patch has passed a
> fstests run but I'd be grateful if you could verify whether you can no l=
onger
> trigger the lockdep warning. Thanks!

I will.
But it may take very long time, a month or two I am afraid.
If you don't receive any mail about this matter in next few months, then
it means everything is fine.

Thnak you
J. R. Okajima
