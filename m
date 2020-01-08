Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2986B134797
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 17:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbgAHQUI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 11:20:08 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:55868 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbgAHQUI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:20:08 -0500
Received: by mail-pj1-f67.google.com with SMTP id d5so1277430pjz.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jan 2020 08:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GdSemLbuvGf99jA7FKJ1LqfntVkD9S1T+aY5do5dg8s=;
        b=TH9dC6nGRGe2+V+iVPfovTa+g2qZ7X6u1empZFWldNatHJIoBQu13qdDCBAES75KXZ
         /+TJe6axQo0ZnAjD2pKh6ryxXmEatq9NegmN6YUj4ibh8/UJL1rTkQAtAKUWgSrCQZCs
         DrsGWWzQtg3q/nTATVg3CCMVkNU8OWE/AFYkDIjc1EcxPAdBZoT61HHSou1jnid093RT
         VYtvDYOvfTBrEXj9fLmOMDQX+DZ13XpwgSugp6anrMNOC5G0NnhTbDN6Vbu7SPipDnYK
         jYAPrNZNC8xNA82IHz5sg6iIB+OEZKLMIK3yxPkUy2IdeVCcWPFCkZ0ZjWhx/wCLB6uR
         Bufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GdSemLbuvGf99jA7FKJ1LqfntVkD9S1T+aY5do5dg8s=;
        b=n74t89EMf4rLFILaTwUfi6i8meZE7cmY0dQ4Dqd2dzL6I8OnC2Mr+zTil4q4PAk8E0
         6+K04xyYhCQNETULUQ5RSMkrXi7xmUw10SK04ucLBM5dHxWCWVrOfIByLDeC8e7cPygG
         QG3nBZlrHHfEHmnOaOhxlcDIIeN/uDZgF6gbgqcHrzvelKQ8TwIM+1RFQbbafA0z0+9C
         ayX2jexFTvmOy646c6Mk/8h3UA57wq+Esq/3UyOuBkheTt4uFx6fF1kpnJ5L4P0zz39o
         GeFipvZZOXpG4VIjcEDEUk/WYz3XYlGatKepLDppnkeRbpAD6Q+qxUQdPUis9k0LhdDd
         pGLw==
X-Gm-Message-State: APjAAAUA0pw/i3tD5/z6tOoKcYez8zcwsOATVQ2n/T5QGEZNE7AiWo0G
        IdyS2L9aIHKw4VFBt2ulBMquBQ0lTGM=
X-Google-Smtp-Source: APXvYqyrcK6xCineXEDBlWWpVO2G7JbMJBSOvDevtHujnslNkvy1N5fC5iSrnGJttt4KNle2GEU7/Q==
X-Received: by 2002:a17:902:6a8c:: with SMTP id n12mr6220678plk.152.1578500407429;
        Wed, 08 Jan 2020 08:20:07 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1130::1133? ([2620:10d:c090:180::38c8])
        by smtp.gmail.com with ESMTPSA id i17sm4240476pfr.67.2020.01.08.08.20.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 08:20:06 -0800 (PST)
Subject: Re: [PATCH 3/6] io_uring: add support for IORING_OP_OPENAT
To:     Stefan Metzmacher <metze@samba.org>, io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
References: <20200107170034.16165-1-axboe@kernel.dk>
 <20200107170034.16165-4-axboe@kernel.dk>
 <82a015c4-f5b9-7c85-7d80-78964cb0d82e@samba.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4ccb935c-7ff9-592f-8c27-0af3d38326d7@kernel.dk>
Date:   Wed, 8 Jan 2020 09:20:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <82a015c4-f5b9-7c85-7d80-78964cb0d82e@samba.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/8/20 6:05 AM, Stefan Metzmacher wrote:
> Hi Jens,
> 
>> This works just like openat(2), except it can be performed async. For
>> the normal case of a non-blocking path lookup this will complete
>> inline. If we have to do IO to perform the open, it'll be done from
>> async context.
> 
> Did you already thought about the credentials being used for the async
> open? The application could call setuid() and similar calls to change
> the credentials of the userspace process/threads. In order for
> applications like samba to use this async openat, it would be required
> to specify the credentials for each open, as we have to multiplex
> requests from multiple user sessions in one process.
> 
> This applies to non-fd based syscall. Also for an async connect
> to a unix domain socket.
> 
> Do you have comments on this?

The open works like any of the other commands, it inherits the
credentials that the ring was setup with. Same with the memory context,
file table, etc. There's currently no way to have multiple personalities
within a single ring.

Sounds like you'd like an option for having multiple personalities
within a single ring? I think it would be better to have a ring per
personality instead. One thing we could do to make this more lightweight
is to have rings that are associated, so that we can share a lot of the
backend processing between them.

-- 
Jens Axboe

