Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D48BA05F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2019 17:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfH1PQW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Aug 2019 11:16:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38542 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfH1PQV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Aug 2019 11:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8K7w75RPW6v4R35r6JmgUfk3dHW0nTr/NpQB6sJf4qo=; b=pWWEOSGTyudk/6A10hR6Rlhjw
        A4Sphe4p05lJ/Hb8GVFUvYM1J6Jd9a+5Nsc4/cOPgWOGDKCeIMBRHYi6Is72mY5VWXV7d/+EG1nh7
        uMdv+ItX2xYd6/5PvNkTgEuRCp56CX+LySr6Y2AgZ87P4cmObrP9U0L15xxANZr/uKRJlC73WP6oX
        nMqlGIWRngHtKm7S+mfZ1p3YdpzPuTr+nyl8Ui4PbkslY7s+e1rS0bWwBeA+P4UY10THQRCzLRrwZ
        iWQDqh0cG3c0OqOwh53z3Tvoj/ml9ig9cP2h39LohZszaL18S5oYgdA1y/3trV8EeMZYE0eLe7Z5r
        OgCLEFGZQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i2zfs-0000aY-9Y; Wed, 28 Aug 2019 15:15:52 +0000
Date:   Wed, 28 Aug 2019 08:15:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     linuxppc-dev@lists.ozlabs.org,
        David Hildenbrand <david@redhat.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Breno Leitao <leitao@debian.org>,
        Michael Neuling <mikey@neuling.org>,
        Firoz Khan <firoz.khan@linaro.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Joel Stanley <joel@jms.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 1/4] fs: always build llseek.
Message-ID: <20190828151552.GA16855@infradead.org>
References: <cover.1566936688.git.msuchanek@suse.de>
 <80b1955b86fb81e4642881d498068b5a540ef029.1566936688.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80b1955b86fb81e4642881d498068b5a540ef029.1566936688.git.msuchanek@suse.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 27, 2019 at 10:21:06PM +0200, Michal Suchanek wrote:
> 64bit !COMPAT does not build because the llseek syscall is in the tables.

Well, this will bloat thinkgs like 64-bit RISC-V for no good reason.
Please introduce a WANT_LSEEK like symbol that ppc64 can select instead.
