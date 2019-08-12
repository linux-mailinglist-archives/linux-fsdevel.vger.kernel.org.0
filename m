Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBB3289C81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 13:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfHLLWw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 07:22:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41272 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbfHLLWw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 07:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cht7uww+B5DA9F6FlWTE0WpmEfRCeWxH7Rm+6z3Ak/k=; b=FdUL4zQhtulB9BWWd0dE383kY
        FcbfXv1syxB9bnes3g313f5RdHDuZPpYKbKls3auqIoRxJ9d1o9TeZVGulrE2LB9uiUo4CS/4WI9n
        LTO4/MgNJrzqJx6ZsuYXAu8swejJ6R89FMYm9hedZhoG3cxlYcLC2soZiH/LIbedgOGyvixuk9HJ1
        yCDkx/Z6wDaFO1WjjwEIQgQF1l5tjt3KuBJiif+Ayem1bqD5ODLEJ0LCIog/LmO7F1WET1o5DTQec
        GNIjbWxoD4h0lY/iTOiZPGniw9J00Miz+ZOzzEpszSbWiu1cktceUtXTROx4L1yyVFxaxLG0i1DNu
        rkr3iG3Tg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hx8PX-0005j1-G1; Mon, 12 Aug 2019 11:22:47 +0000
Date:   Mon, 12 Aug 2019 04:22:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Merging virtualbox shared-folder VFS driver through
 drivers/staging?
Message-ID: <20190812112247.GA21901@infradead.org>
References: <f2a9c3c0-62da-0d70-4062-47d00ab530e0@redhat.com>
 <20190811074005.GA4765@kroah.com>
 <20190811074348.GA13485@infradead.org>
 <20190811075042.GA6308@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811075042.GA6308@kroah.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 11, 2019 at 09:50:42AM +0200, Greg Kroah-Hartman wrote:
> Lustre was a mistake.  erofs is better in that there are active
> developers working to get it out of staging.  We would also need that
> here for this to be successful.

I think erofs could have been handled much easier with a bunch of
iterations of normal submissions.  Bet yes, the biggest problem was
lustre.
