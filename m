Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9030D639DF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2019 19:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfGIREK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jul 2019 13:04:10 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:49786 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725816AbfGIREK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jul 2019 13:04:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 096998EE15F;
        Tue,  9 Jul 2019 10:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562691846;
        bh=fHLhVNRZX5i6YF+IH8IXJ7fw4skeuYlN0YWtHKitwus=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=W7kYCPqCtFlGXoz2hjMn6mxlI6Ti/6X+VL/ND0W+iKJLVQA1ayOK1BoWPUqaYKWN0
         AocbxFxY4M944e7QsrqFmg/NSOnJwpmGlPuaUqn/3zDQchOyR3XUVeqO0iyuMCTaX9
         NWLylOImiLMNlOAY5I02yQcK9HGQ51uEkfLv13cQ=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GiLem5l3gMZC; Tue,  9 Jul 2019 10:04:05 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 318A48EE247;
        Tue,  9 Jul 2019 10:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562691830;
        bh=fHLhVNRZX5i6YF+IH8IXJ7fw4skeuYlN0YWtHKitwus=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=iCSfQvsWoZjCVRF6BGTJnzq63SLrHKIlcQp0PedW2Fuhbca5XUNu9VaNVQaeB9Id+
         Oj0U95zaf4O0lfio4/1APisTVW0zh4L6cCB7DCUpH+ku98okvS0tfI4CL6XGOvg5cH
         EgIC2YgJha012VT/zBCfy6ETAizeuxJPWXSMgdeE=
Message-ID: <1562691829.3362.68.camel@HansenPartnership.com>
Subject: Re: exfat filesystem
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Sasha Levin <sashal@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Valdis =?UTF-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, kys@microsoft.com
Date:   Tue, 09 Jul 2019 10:03:49 -0700
In-Reply-To: <20190709163744.GS10104@sasha-vm>
References: <21080.1562632662@turing-police>
         <20190709045020.GB23646@mit.edu>
         <20190709112136.GI32320@bombadil.infradead.org>
         <20190709153039.GA3200@mit.edu>
         <20190709154834.GJ32320@bombadil.infradead.org>
         <20190709163744.GS10104@sasha-vm>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2019-07-09 at 12:37 -0400, Sasha Levin wrote:
> On Tue, Jul 09, 2019 at 08:48:34AM -0700, Matthew Wilcox wrote:
> > On Tue, Jul 09, 2019 at 11:30:39AM -0400, Theodore Ts'o wrote:
> > > On Tue, Jul 09, 2019 at 04:21:36AM -0700, Matthew Wilcox wrote:
> > > > How does
> > > > https://www.zdnet.com/article/microsoft-open-sources-its-entire
> > > > -patent-portfolio/
> > > > change your personal opinion?
> > > 
> > > According to SFC's legal analysis, Microsoft joining the OIN
> > > doesn't mean that the eXFAT patents are covered, unless
> > > *Microsoft* contributes the code to the Linux usptream
> > > kernel.  That's because the OIN is governed by the Linux System
> > > Definition, and until MS contributes code which covered by the
> > > exFAT patents, it doesn't count.
> > > 
> > > For more details:
> > > 
> > > https://sfconservancy.org/blog/2018/oct/10/microsoft-oin-exfat/
> > > 
> > > (This is not legal advice, and I am not a lawyer.)
> > 
> > Interesting analysis.  It seems to me that the correct forms would
> > be observed if someone suitably senior at Microsoft accepted the
> > work from Valdis and submitted it with their sign-off.  KY, how
> > about it?
> 
> Huh, that's really how this works? Let me talk with our lawyers to
> clear this up.

Not exactly, no.  A corporate signoff is useful evidence of intent to
bind patents, but a formal statement would be better and wouldn't
require a signoff.  The SFC analysis is also a bit lacking:
hypothetically if exfat became part of Linux, it would be covered by
the OIN legal definition which would place MS in an untenable position
with regard to the mutual defence pact if it still wanted to enforce
FAT patents against Linux.

> Would this mean, hypothetically, that if MS has claims against the
> kernel's scheduler for example, it can still assert them if no one
> from MS touched the code? And then they lose that ability if a MS
> employee adds a tiny fix in?

No.  You're already shipping a linux kernel, that makes Microsoft a
distributor meaning you're bound by the GPL express patent licences so
any patent Microsoft has on technology in the Linux kernel would be
unenforceable under that.  Plus as a member of OIN, you've guaranteed
not to sue for any patent that reads on the Linux System definition,
which is also a promise you can be held to.

James

