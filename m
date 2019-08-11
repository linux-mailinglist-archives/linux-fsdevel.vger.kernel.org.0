Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF7AC891DC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Aug 2019 15:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfHKNge (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Aug 2019 09:36:34 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:52261 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfHKNge (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Aug 2019 09:36:34 -0400
Received: by mail-wm1-f52.google.com with SMTP id s3so9951979wms.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Aug 2019 06:36:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s+65aQQBYuAVSmTlCDNSdC1V5S4cq8B+4jNxLYAVFmE=;
        b=cSuVHFGo1zlUGhIlCoGLu9b3aKxBxKddBDE+qPwFTioUhrEpNU+tcYckibswkogcgm
         hpsrMhHdlnUiwkffeZAYDe1yC2nYwTz0NO+H8VtO3uXtKE+Lh/mlSz5lo75LSb8qg8hv
         Gv3UxWIPCPDN5MDSyELZd3wm6o/nvEQnKdotIAVwtmkTp64VsxRqRC2vJ/Wcdk987zdH
         guxP0X4RiGiHaGQdygE+slcpwGXNZrd+5h7BjtXhhXUc8z5ABaaDpNbSz39wZQYQvAe2
         FGCFkV+Zti3PGsex7yMfYikkR48V1na33tLntL/BNto79R71KrE5y1Z0vOg/UwN0IacU
         dJGg==
X-Gm-Message-State: APjAAAWO/cQ6lJb3jfqU+YUzDEALLER+x+WFOEfmQhaJkP9D7X9HwF+i
        mWCruxaHuLufyP3KvbUvQGF1u24zxbc=
X-Google-Smtp-Source: APXvYqzlc7Q4yA1qXLBOCCdA+70OQBSn6MEa4LrxkSHKELjtvVdvdXELJdlPQV49H8ccwmpMfyLjhA==
X-Received: by 2002:a7b:c212:: with SMTP id x18mr21939175wmi.77.1565530591820;
        Sun, 11 Aug 2019 06:36:31 -0700 (PDT)
Received: from dhcp-44-196.space.revspace.nl ([2a01:4f8:1c0c:6c86:46e0:a7ad:5246:f04d])
        by smtp.gmail.com with ESMTPSA id j20sm8412674wre.65.2019.08.11.06.36.30
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 06:36:31 -0700 (PDT)
Subject: Re: Merging virtualbox shared-folder VFS driver through
 drivers/staging?
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
References: <f2a9c3c0-62da-0d70-4062-47d00ab530e0@redhat.com>
 <20190811005012.GA7491@bombadil.infradead.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <320a587b-9f66-8758-2371-ff9885ee2f44@redhat.com>
Date:   Sun, 11 Aug 2019 15:36:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190811005012.GA7491@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 8/11/19 2:50 AM, Matthew Wilcox wrote:
> On Sun, Aug 11, 2019 at 12:25:03AM +0200, Hans de Goede wrote:
>> But ATM, since posting v12 of the patch, it has again been quiet for
>> 2 months again. Since this driver is already being used as addon /
>> our of tree driver by various distros, I would really like to get it
>> into mainline, to make live easier for distros and to make sure that
>> they use the latest version.
> 
> fwiw, v12 never made it to the list.  0/1 did, but 1/1 didn't.

Hmm, looks like you are right, weird. I will resend v12 right away.

Regards,

Hans
