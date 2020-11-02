Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 657052A3136
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 18:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbgKBRQz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 12:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbgKBRQx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 12:16:53 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A157C061A04
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 09:16:47 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id h6so18417645lfj.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2020 09:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jasiak-xyz.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pOGkUpEQFpFLpHbYfDTTEGGqLarAut/n6gfwvOUJSSs=;
        b=R0CuAkDlRj/epsCtNDiO769hiBOguzKFe+DAO8MOds8DX2VlHRtmw3lNcLg1khZm/I
         0OYbo3y1YmRr3DWOHUPC3VO+LKCpSBtIQlTsbOEbrbHUrT5frl/+Zjw/feqjxNer7C3j
         gEKmBWa6Jy/ij4WIWEoq1zfN//SoOc5iwURF5lCocD/B48nTK9DrbB+oyH65TnprnOZp
         bu4RtGxZCEFmKmTU2tgnCO8H2i/36mK2azwddE2iSqLZPM76RCO9wzIA6Pg2hLGPE5n2
         kX2osXwsAr+x535KbmZvxFbCKo+oOdZF63FpJbChHcGjAjbbqzONAaQ46/zG9edbLLlR
         kshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pOGkUpEQFpFLpHbYfDTTEGGqLarAut/n6gfwvOUJSSs=;
        b=B+yc6mPeVWBlS4sUu2mU4U8YNdF9CkgG8Ja/o9s0CK725z/IbLPSkdpGLKPwL1LthZ
         BhveuF2z6NrzqKu9zyNUDgx4n8RMMRYx1K8dIptv7TghmWxT94SbpO1JzKK9kacqeGZd
         PxSN7l+c9Ys0+HxDWPzMhj0EM803G9OpHI4ZgvgjK8NVP7Enled+xvlr7f8MowQBOIOw
         sFtgms2SMifUgsdCxEd8x7hCdPh66f35SPMqOHjl1OeTxMMglnQEYStCblzBmt1/sSST
         Qng41/R8gHX2lhLRcLW/H9Rk0y2Y8IWjgDKvhFSFpUamTrfU7V/9SIWxHCKwiEpfRXsW
         xwsw==
X-Gm-Message-State: AOAM533NNocs786TUO2iurbwU9KHxX3EaHVULowAr4J1pyBjTBcU4pnW
        jIopoyT5lnpfRnhP/yQ9WtIqU7xVLbx34udI
X-Google-Smtp-Source: ABdhPJzZWGAZNTQelf6KybogENzY/nGSEIm8ur8Obr1OHpGzBzHe9kVOd445QBOnfVWYevvhTxUksg==
X-Received: by 2002:a19:c70f:: with SMTP id x15mr5758531lff.296.1604337405683;
        Mon, 02 Nov 2020 09:16:45 -0800 (PST)
Received: from gmail.com (wireless-nat-78.ip4.greenlan.pl. [185.56.211.78])
        by smtp.gmail.com with ESMTPSA id b18sm2485747lfp.89.2020.11.02.09.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 09:16:45 -0800 (PST)
Date:   Mon, 2 Nov 2020 18:16:43 +0100
From:   =?utf-8?B?UGF3ZcWC?= Jasiak <pawel@jasiak.xyz>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: PROBLEM: fanotify_mark EFAULT on x86
Message-ID: <20201102171643.GA5870@gmail.com>
References: <20201101212738.GA16924@gmail.com>
 <20201102122638.GB23988@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201102122638.GB23988@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 02/11/20, Jan Kara wrote:
> Strange. Thanks for report. Looks like some issue got created / exposed
> somewhere between 5.5 and 5.9 (actually probably between 5.5 and 5.7
> because the Linaro report you mentioned [1] is from 5.7-rc6). There were
> no changes in this area in fanotify, I think it must have been some x86
> change that triggered this. Hum, looking into x86 changelog in that time
> range there was a series rewriting 32-bit ABI [2] that got merged into
> 5.7-rc1. Can you perhaps check whether 5.6 is good and 5.7-rc1 is bad?

5.6 works.
5.7-rc1 doesn't work.

-- 

Paweł Jasiak
