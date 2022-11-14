Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F96627D17
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Nov 2022 12:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236947AbiKNL4E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 06:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235782AbiKNLzj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:55:39 -0500
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6FD27FE8;
        Mon, 14 Nov 2022 03:50:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1668426643; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=OtESVbGmChxztNzXnFBfiybknuMz3B6hj/pNNJc1egfO7hH52iSl0+p/yRrWFlSXaSx3qFJwfSenaZUX/YhV+C+Zz3DUuEzMxAISIjkzaPevxItZXwFA89vrxEZ+0jJ1tkptvtMMy3FjKtaP7onPVUQq4fF38QNw7ZPg6oA+0pk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1668426643; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=m9TQM9OSyiWK+Pi32AurcCv7tg4Yb7N2ZmwTgbOjqak=; 
        b=YBxvrbyXfWNK4KwtRutnQGsYRdXmH+pAPTS+nsGWq8Jp8jzLCKG3ezBXiwnIG+D0Gu9V+kL6CDRyYvkQmR8J4stkHW3er9+knnrcn0LNl3wb3ywOge85o+LVza6ui8rO4E2/Qr2tqLyDMX2x/ngLwsihLVe+bsvTgvUqfTf5bVo=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1668426643;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Message-ID:Date:Date:MIME-Version:To:To:Cc:Cc:References:Subject:Subject:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=m9TQM9OSyiWK+Pi32AurcCv7tg4Yb7N2ZmwTgbOjqak=;
        b=JVKzN4+MBnO88cEmURblVxcYCJ5DhYmma0KFZbqytAGCUB0yUhrxrMhXVQJPR81S
        Cdc81k6wSUMoSQbLMfULt6vaOR8KFhgM/YBLuWr/FL0ozNpeX1w88MPAcWIORDkvcMw
        gxA34UXyLhKL1laGn4dkuFRNqMx4M4CQF07gpUJ4=
Received: from [192.168.1.9] (110.226.30.173 [110.226.30.173]) by mx.zoho.in
        with SMTPS id 166842664273543.03099842188135; Mon, 14 Nov 2022 17:20:42 +0530 (IST)
Message-ID: <2aa67892-ac99-c46e-b2b6-2f8a5944a919@siddh.me>
Date:   Mon, 14 Nov 2022 17:20:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
To:     syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com
References: <000000000000f2075605d04f9964@google.com>
Subject: Re: [syzbot] WARNING in iomap_iter
Content-Language: en-US, en-GB, hi-IN
From:   Siddh Raman Pant <code@siddh.me>
In-Reply-To: <000000000000f2075605d04f9964@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Syzkaller posted a new reproducer unrelated to the issue causing
the older crash under this same issue, since the same function
triggers the newer warning.

This time it is related to erofs setting length equal to zero in
z_erofs_iomap_begin_report().

Thanks,
Siddh
