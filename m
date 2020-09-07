Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497BD26053B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Sep 2020 21:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgIGTnY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Sep 2020 15:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728657AbgIGTnV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Sep 2020 15:43:21 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3C6C061575
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Sep 2020 12:43:21 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f18so9074837pfa.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Sep 2020 12:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K6oyk7UyHJ86Ue6WLa0Z402qJDZy9lZz9Y0VEUrzUfI=;
        b=tPWQpPw2e1CQKEQZ3KsMYIXbn9FtEMti5vV2IhiENWBbWyE/xNIFhfg6jKEjRW+FsZ
         7QSRxiMZgjRoyLPmyZMOLVp8XWjj0QsfnjvZ5LOIf5N9VZ1nQUXM5LY04PVZnanuGQRY
         JlK9pkOa24F3UyzEL/51s1qMx0xd0E0ArzCWG7RmmWgdmWa0GW2bBpmCJuFtXwG06OM4
         AlOWZimuw70gZC9YGZmdhrtPg3v1kB6V6+cgouxv5YgrZHET5uKwM+yags7he2gDnQU6
         Mbadi7KUP3suNtupiTAttsrtNO/uDa/5CLDYZDhdJpczZHNAyWuX4g4EUUtx8wiGKkNc
         md8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K6oyk7UyHJ86Ue6WLa0Z402qJDZy9lZz9Y0VEUrzUfI=;
        b=g/kgH+jJvPgrQnLew0kYYIDtX4ZQZyxdZ0M5oWIykf3qeqx9af1O07W3cx9CWfvF3B
         ojpF2VmUiy/ngsjGzU69LK8/5nIVWfVf1u7c2RpM9EveM3eDu0FjlCze1qSrsK2Dv8Pk
         3dsXGMMlyEOmcvcMTK5dgDJ9hENzADeXd66TAcy3BwM7LZi+Tbyam8CwrtLyXH3yGVe6
         Zcs/2ddaJJdyTJuCDIaln7o2JtGUDPvCxugA/7WF9qlYZoV2cOVHdN2TomDB+BnyOvjG
         +g9Q7koIW95qOYFaBZ/ecfpxy7BsbSRcXCtEopsNhCmiAAhy4DTQUWFx9P2vOTrFVEDi
         oQow==
X-Gm-Message-State: AOAM530RUQAAo4zI/vcHwBCrgHiL/Y68dIjOcwFn8BfwI7hT+RkjCCMM
        UeU/MfwWRx7NRy2isfcsV8mYbA==
X-Google-Smtp-Source: ABdhPJwwfzjrLqlUEEjMkHC3/aU1gERrxpqwrUDMBIGZTwj/n+jqsRBQ28klhPaAqo6GSK2BZ2b3Ew==
X-Received: by 2002:a63:9d82:: with SMTP id i124mr17611758pgd.336.1599507800895;
        Mon, 07 Sep 2020 12:43:20 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id a23sm11429844pgv.86.2020.09.07.12.43.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2020 12:43:20 -0700 (PDT)
Subject: Re: [PATCH] fs: align IOCB_* flags with RWF_* flags
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>
References: <95de7ce4-9254-39f1-304f-4455f66bf0f4@kernel.dk>
Message-ID: <4e51e236-f996-feb1-1f8d-c94b4163551c@kernel.dk>
Date:   Mon, 7 Sep 2020 13:43:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <95de7ce4-9254-39f1-304f-4455f66bf0f4@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/31/20 12:08 PM, Jens Axboe wrote:
> We have a set of flags that are shared between the two and inherired
> in kiocb_set_rw_flags(), but we check and set these individually.
> Reorder the IOCB flags so that the bottom part of the space is synced
> with the RWF flag space, and then we can do them all in one mask and
> set operation.
> 
> The only exception is RWF_SYNC, which needs to mark IOCB_SYNC and
> IOCB_DSYNC. Do that one separately.
> 
> This shaves 15 bytes of text from kiocb_set_rw_flags() for me.

Al, are you OK with me queueing this one up? I'm fine either way,
obviously no dependencies for this one, just want to ensure it isn't
dropped.

-- 
Jens Axboe

