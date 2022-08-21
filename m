Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF20A59B34B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Aug 2022 13:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiHUL2h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Aug 2022 07:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiHUL2g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Aug 2022 07:28:36 -0400
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8885EDEA0;
        Sun, 21 Aug 2022 04:28:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1661081278; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=J/l3TIoZx19pPGAUYOmMDQnjn8A3j3FKCBPkeOVv5Ys5yj02tiI9njKfNluhUKtBt+pAQHBH68IPGN7WPi82eTwLmFbuXbfYH7Eri1FofEMfiea6AWyEFjPOjBBUFQf6bdeqNVBMmL1VE3iq6EOAMx3SxL7bHwhIZpZTEGs8zQM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1661081278; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=hZHOJ4pLEcPURWdMDp45Lhwm0s8aMJkkfiBCCXq1U+o=; 
        b=FNxLvxXzyl/V5j19U7fG4KHEfQytJXswR+Awxisv3X1godXkgPYk+3InumXFM1BYAyfqXtR1k5TFBX4l+70f4kkQuNpqSoTPNjSmrAH9TseB8u9uxJdc3h7g2oRGoXMDyczpXlz7kOgw7GZ/SgsQIU5iLA8hSBvGg1jFbqcmBUQ=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1661081278;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=hZHOJ4pLEcPURWdMDp45Lhwm0s8aMJkkfiBCCXq1U+o=;
        b=RhIDrQVRARpx33zkVcedcuacvLngNutwY66pTrO903N6f/uMVnNA/N7+40ApVzDH
        KlMfqhiFgf76zJfNYoykXY1HtpmVIiPWJqLFU7wSFKpx7wf3zkdoHuYC2ZMPp6hhm3d
        ToTaSW/+GLkgsqnjo5WA9Un151/BNfHFFBZLsbz4=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1661081267208198.2378591768578; Sun, 21 Aug 2022 16:57:47 +0530 (IST)
Date:   Sun, 21 Aug 2022 16:57:47 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "hch" <hch@infradead.org>
Cc:     "matthew wilcox" <willy@infradead.org>,
        "david" <david@fromorbit.com>, "djwong" <djwong@kernel.org>,
        "fgheet255t" <fgheet255t@gmail.com>,
        "linux-ext4" <linux-ext4@vger.kernel.org>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "linux-xfs" <linux-xfs@vger.kernel.org>,
        "riteshh" <riteshh@linux.ibm.com>,
        "syzbot+a8e049cd3abd342936b6" 
        <syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com>,
        "syzkaller-bugs" <syzkaller-bugs@googlegroups.com>
Message-ID: <182c028abf0.2dc6f7c973088.2963173753499991828@siddh.me>
In-Reply-To: <YwHQsbH/aYtH5pVs@infradead.org>
References: <20220818110031.89467-1-code@siddh.me>
 <20220818111117.102681-1-code@siddh.me>
 <Yv5RmsUvRh+RKpXH@casper.infradead.org>
 <182b18b5d92.7a2e2b1623166.1514589417142553905@siddh.me> <YwHQsbH/aYtH5pVs@infradead.org>
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

On Sun, 21 Aug 2022 11:59:05 +0530  Christoph Hellwig  wrote:
> On Thu, Aug 18, 2022 at 08:51:16PM +0530, Siddh Raman Pant wrote:
> > On Thu, 18 Aug 2022 20:20:02 +0530  Matthew Wilcox  wrote:
> > > I don't think changing these from u64 to s64 is the right way to go.
> > 
> > Why do you think so? Is there somnething I overlooked?
> > 
> > I think it won't intorduce regression, since if something is working,
> > it will continue to work. If something does break, then they were
> > relying on overflows, which is anyways an incorrect way to go about.
> 
> Well, for example userspace code expecting unsignedness of these
> types could break.  So if we really think changing the types is so
> much preferred we'd need to audit common userspace first.  Because
> of that I think the version proposed by willy is generally preferred.

Alright.

> > Also, it seems even the 32-bit compatibility structure uses signed
> > types.
> 
> We should probably fix that as well.

Isn't having signed type how it is should be though? Or do you mean need
to fix assignment in the conversions (like in loop_info64_from_compat)?

Thanks,
Siddh
