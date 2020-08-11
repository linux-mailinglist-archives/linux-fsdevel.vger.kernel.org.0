Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1A2241D38
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 17:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgHKPcx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 11:32:53 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:41116 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728859AbgHKPcx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:32:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id E738F8EE19D;
        Tue, 11 Aug 2020 08:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1597159972;
        bh=wWrttx+iJhZF4TwfmlzLv+L9PM0TdD9Fc3uir7nFLMM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=XjfA1fqdWroJDmq6NYLlvqAen2Eu9mx40k7dwajpO5cdqxz8OBHTAj7LtnXt5D77r
         yHD8FpZ2B8DPuLh9B0vQ3+a4we6/g8GeUBH/MEhQmafs87XW0uTaOy4AkMr/y85xEu
         no3iCijZ0aDY7SPirzPrfB1ZKiYDgL37sKqkoDNM=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id b3YM1B3UJc5Z; Tue, 11 Aug 2020 08:32:51 -0700 (PDT)
Received: from [153.66.254.174] (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 7D8168EE149;
        Tue, 11 Aug 2020 08:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1597159971;
        bh=wWrttx+iJhZF4TwfmlzLv+L9PM0TdD9Fc3uir7nFLMM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LWfToPsdUAM4OHjosIhR5/dzJ35cRneHKHc+1ZzcbqKKxvJcvDFZvI6pjja2WIkmc
         +K+U4TpQP2HX9w8ZGbglVlC1eURNIPwla3RFrIuEXR75FGSSeUnGceNMM64gUYwCq7
         IZjHJh9XO1JkIu1Kj6UVNO92zS1mMzzP3p+jQrFY=
Message-ID: <1597159969.4325.21.camel@HansenPartnership.com>
Subject: Re: [dm-devel] [RFC PATCH v5 00/11] Integrity Policy Enforcement
 LSM (IPE)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Chuck Lever <chucklever@gmail.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, James Morris <jmorris@namei.org>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Pavel Machek <pavel@ucw.cz>, Sasha Levin <sashal@kernel.org>,
        snitzer@redhat.com, dm-devel@redhat.com,
        tyhicks@linux.microsoft.com, agk@redhat.com,
        Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>, nramas@linux.microsoft.com,
        serge@hallyn.com, pasha.tatashin@soleen.com,
        Jann Horn <jannh@google.com>, linux-block@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, mdsakib@microsoft.com,
        open list <linux-kernel@vger.kernel.org>, eparis@redhat.com,
        linux-security-module@vger.kernel.org, linux-audit@redhat.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        jaskarankhurana@linux.microsoft.com
Date:   Tue, 11 Aug 2020 08:32:49 -0700
In-Reply-To: <16C3BF97-A7D3-488A-9D26-7C9B18AD2084@gmail.com>
References: <20200728213614.586312-1-deven.desai@linux.microsoft.com>
         <20200802115545.GA1162@bug> <20200802140300.GA2975990@sasha-vm>
         <20200802143143.GB20261@amd>
         <1596386606.4087.20.camel@HansenPartnership.com>
         <fb35a1f7-7633-a678-3f0f-17cf83032d2b@linux.microsoft.com>
         <1596639689.3457.17.camel@HansenPartnership.com>
         <alpine.LRH.2.21.2008050934060.28225@namei.org>
         <b08ae82102f35936427bf138085484f75532cff1.camel@linux.ibm.com>
         <329E8DBA-049E-4959-AFD4-9D118DEB176E@gmail.com>
         <da6f54d0438ee3d3903b2c75fcfbeb0afdf92dc2.camel@linux.ibm.com>
         <1597073737.3966.12.camel@HansenPartnership.com>
         <6E907A22-02CC-42DD-B3CD-11D304F3A1A8@gmail.com>
         <1597124623.30793.14.camel@HansenPartnership.com>
         <16C3BF97-A7D3-488A-9D26-7C9B18AD2084@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-08-11 at 10:48 -0400, Chuck Lever wrote:
> > On Aug 11, 2020, at 1:43 AM, James Bottomley
> > <James.Bottomley@HansenPartnership.com> wrote:
> > On Mon, 2020-08-10 at 19:36 -0400, Chuck Lever wrote:
[...]
> > > Thanks for the help! I just want to emphasize that documentation
> > > (eg, a specification) will be critical for remote filesystems.
> > > 
> > > If any of this is to be supported by a remote filesystem, then we
> > > need an unencumbered description of the new metadata format
> > > rather than code. GPL-encumbered formats cannot be contributed to
> > > the NFS standard, and are probably difficult for other
> > > filesystems that are not Linux-native, like SMB, as well.
> > 
> > I don't understand what you mean by GPL encumbered formats.  The
> > GPL is a code licence not a data or document licence.
> 
> IETF contributions occur under a BSD-style license incompatible
> with the GPL.
> 
> https://trustee.ietf.org/trust-legal-provisions.html
> 
> Non-Linux implementers (of OEM storage devices) rely on such
> standards processes to indemnify them against licensing claims.

Well, that simply means we won't be contributing the Linux
implementation, right? However, IETF doesn't require BSD for all
implementations, so that's OK.

> Today, there is no specification for existing IMA metadata formats,
> there is only code. My lawyer tells me that because the code that
> implements these formats is under GPL, the formats themselves cannot
> be contributed to, say, the IETF without express permission from the
> authors of that code. There are a lot of authors of the Linux IMA
> code, so this is proving to be an impediment to contribution. That
> blocks the ability to provide a fully-specified NFS protocol
> extension to support IMA metadata formats.

Well, let me put the counterpoint: I can write a book about how linux
device drivers work (which includes describing the data formats), for
instance, without having to get permission from all the authors ... or
is your lawyer taking the view we should be suing Jonathan Corbet,
Alessandro Rubini, and Greg Kroah-Hartman for licence infringement?  In
fact do they think we now have a huge class action possibility against
O'Reilly  and a host of other publishers ...

> > The way the spec process works in Linux is that we implement or
> > evolve a data format under a GPL implementaiton, but that
> > implementation doesn't implicate the later standardisation of the
> > data format and people are free to reimplement under any licence
> > they choose.
> 
> That technology transfer can happen only if all the authors of that
> prototype agree to contribute to a standard. That's much easier if
> that agreement comes before an implementation is done. The current
> IMA code base is more than a decade old, and there are more than a
> hundred authors who have contributed to that base.
> 
> Thus IMO we want an unencumbered description of any IMA metadata
> format that is to be contributed to an open standards body (as it
> would have to be to extend, say, the NFS protocol).

Fine, good grief, people who take a sensible view of this can write the
data format down and publish it under any licence you like then you can
pick it up again safely.  Would CC0 be OK? ... neither GPL nor BSD are
document licences and we shouldn't perpetuate bad practice by licensing
documentation under them.

James

