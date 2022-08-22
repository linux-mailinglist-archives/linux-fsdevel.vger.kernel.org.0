Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B18659C20F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Aug 2022 17:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235827AbiHVPDF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 11:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235828AbiHVPC6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:02:58 -0400
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9754939B8D;
        Mon, 22 Aug 2022 08:02:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1661180551; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=QSf4nmiLJx5ozxBoq+i1Fb0X2Eb0ZWVcugm0/fOUu4TUeNhfuzECMygE58LgJprE6gcIFmIjBQktQia5WMx6gFf1qp9kKmxVIzfFcgyFp7/j6fxyF7Mo71nRtqi0Y1Q0MvlDWBV4LZwHw6GSDE1PhH/s4zvrgyPTSY/hShN219I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1661180551; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=/u/Wny60TF8LyG87rvYOmsY9vkwmsddSZaOyk12HpDI=; 
        b=edKXGteBo64NDoFyisLen9BIUUSJVL/v7jUdSeoOaTOTLToKILM9BYvmckQyrgjNEI3FgSspAMu2ENXXxg7T639DaakkIxkQDk1tBHori7md3DYeiBKocRlvI+0XHQD+ixFAJuG/W1YhVwdlStQzWtvQw8dZgcI3/uKdrIRvM1Y=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1661180551;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=/u/Wny60TF8LyG87rvYOmsY9vkwmsddSZaOyk12HpDI=;
        b=nKRg/6yn1laoseGxgZ4Byzzs6tgeatmM6XgjGzyaXNxBUtxEl0mnXZnXcpgWEHv/
        fa2KAB+aUJ+YQGYq6AU9Zohca7NUdTW7Hnva6CUOKqxAwXCUvEP3azqlw7CpCs/1asn
        6UwPJeYuVJZAq4fXslD+gxv4HLzuSNfJjpINvrSQ=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1661180540583918.6664486750254; Mon, 22 Aug 2022 20:32:20 +0530 (IST)
Date:   Mon, 22 Aug 2022 20:32:20 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Matthew Wilcox" <willy@infradead.org>
Cc:     "david" <david@fromorbit.com>, "djwong" <djwong@kernel.org>,
        "fgheet255t" <fgheet255t@gmail.com>, "hch" <hch@infradead.org>,
        "linux-ext4" <linux-ext4@vger.kernel.org>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "linux-xfs" <linux-xfs@vger.kernel.org>,
        "riteshh" <riteshh@linux.ibm.com>,
        "syzbot+a8e049cd3abd342936b6" 
        <syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com>,
        "syzkaller-bugs" <syzkaller-bugs@googlegroups.com>
Message-ID: <182c6137693.20a934d213186.5712495322312393662@siddh.me>
In-Reply-To: <YwOYMJrvBuoVye7R@casper.infradead.org>
References: <182c028abf0.2dc6f7c973088.2963173753499991828@siddh.me>
 <20220821114816.24193-1-code@siddh.me>
 <YwOWiDKhVxm7m0fa@casper.infradead.org>
 <182c607e79a.820e4a7012709.6365464609772129416@siddh.me> <YwOYMJrvBuoVye7R@casper.infradead.org>
Subject: Re: [syzbot] WARNING in iomap_iter
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_RED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 22 Aug 2022 20:22:32 +0530  Matthew Wilcox  wrote:
> But it's not an integer.  It's a bitfield.  Nobody checks lo_flags for
> "is it less than zero".  That makes it very different from lo_offset.

Thanks for clarifying, I see where I was wrong. I overlooked its use as a
bitfield.

Thanks,
Siddh
