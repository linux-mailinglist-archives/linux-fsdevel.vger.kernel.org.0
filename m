Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A28616AA3C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 16:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgBXPgH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 10:36:07 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:44238 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727730AbgBXPgG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 10:36:06 -0500
Received: by mail-io1-f66.google.com with SMTP id z16so10646367iod.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2020 07:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=zddawmptTj8O/iOFAeDEIVRJudMFVZUKfFGPqjx1LMk=;
        b=NLvGifZF6nw+IxiFIhrBLRrajvZsnwn1tkIxXaXebNAqQHMSuIBDN2uVpU6oYpef8H
         YcAsxc1k6I4XLVgnP/rr3t6/nGF8DUpFgf0RBC3eDBl1skBwR2b+XcQNzsmb9DkMPk/h
         kTQZaRz76MdM/7+E9AgkSMHFh1DMeJCljGydy2AB6sd75EozDgzhpGd4fszRSu6MkPoH
         d3qbbRezx8I+B8ILIZtOYrllU3XNFtpUiBsIMaZckU4xZ1qaE0AW6VKNpzPzKEyWnE9c
         O9s3ovM1lZjclsudzHwkv1PmmFUUwFjX24yERfq0Bn0s9xZhQkYW4EVxMMsan6OxCF3y
         tHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zddawmptTj8O/iOFAeDEIVRJudMFVZUKfFGPqjx1LMk=;
        b=CYxqqy5GNk7r9XzmNouo3CB3Hf73uSSfdT/QMOT7e4cEtlewv4wkso+jeyrpwI3f2k
         ls2/mtVrEJw+9GnNcHeCGjIlenyh0eLbh97Tuadt3wOXUprDXkl56owUURm1KbiFhNQ3
         Grrq1HUN7ix6epB5aMrGp9e0KzqJep6PGWYNq11yRdRnNlIYymdi3m3181T0/mP2SBVq
         7GkpZs2CdQTc9q3/IxonSsQt6TwFbo0dNWct0BS8X3OMNCPg/tEvV7FdbICAOvU4JLr8
         h9foOo2lHoDeYsrJIJYhaYFHpp7OXlD7X4gtXL9If3VmRB9q8AmPBRgmmqoV3QjH8q2T
         5qsw==
X-Gm-Message-State: APjAAAV7khEXpELp8W9Cspec4IyAfzP8oFZZ/HoKPH/Iq2Bwb2Qgx22T
        ipdpZuS/vyOfa8QUiUb2fdsTMQ==
X-Google-Smtp-Source: APXvYqxJLYN7KxGZRPJQFZnCFWyWjTrI95KeI9Mk/yjMubZC8gJzK/dCmDDDpmGRE3GeVaB1yZIXeA==
X-Received: by 2002:a6b:6604:: with SMTP id a4mr54584788ioc.300.1582558554596;
        Mon, 24 Feb 2020 07:35:54 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v5sm4426550ilg.73.2020.02.24.07.35.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2020 07:35:53 -0800 (PST)
Subject: Re: [PATCH v4 0/3] io_uring: add splice(2) support
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stefan Metzmacher <metze@samba.org>, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1582530525.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <923cc84a-e11f-2a16-2f12-ca3ba2f3ade4@kernel.dk>
Date:   Mon, 24 Feb 2020 08:35:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <cover.1582530525.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/24/20 1:32 AM, Pavel Begunkov wrote:
> *on top of for-5.6 + async patches*
> 
> Not the fastets implementation, but I'd need to stir up/duplicate
> splice.c bits to do it more efficiently.
> 
> note: rebase on top of the recent inflight patchset.

Let's get this queued up, looks good to go to me. Do you have a few
liburing test cases we can add for this?

-- 
Jens Axboe

