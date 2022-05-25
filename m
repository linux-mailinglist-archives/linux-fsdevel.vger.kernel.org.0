Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6689E534474
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 May 2022 21:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346115AbiEYTom (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 May 2022 15:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346035AbiEYTo2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 May 2022 15:44:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7209D1145C;
        Wed, 25 May 2022 12:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S6qisVcKaqKCfdGaJluvCYtDQBbD/bLcDlVDzzD0wUo=; b=d6Lzkm3nKu9wkp/Tn/FwPo54dE
        o7OQMJ82dZigbjNoim9XQ+8czVUTEu9Q+nDeOSKu1iP5PjtnY5/D2ltdqSbP6Zdzd+v5xBWC7uKJf
        myeuJ1iRJEmkG90gqlMTb2KwfFAUdQOm+g99VVCpyLIBc8RpcqoJQgAR2J9Z2H8/fXbWeypdpWhuG
        3UhrDDBbXjBH2N6caTSiJGTTZMi/do7rk40BLwdHIom+fTn7+i75cTYP2GyZROV7K0RyA+ryRCp9d
        Zx04LGEZag2yXoYwXgh6bNMu7jSwy2g1Sd6JCwGEoIdzKzREfw88nAVRndD+aAPrrCLZJLLbUqd/y
        5UD1mlWw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ntwvT-00CT7x-8u; Wed, 25 May 2022 19:44:11 +0000
Date:   Wed, 25 May 2022 12:44:11 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Bird, Tim" <Tim.Bird@sony.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Richard Fontana <fontana@sharpeleven.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "joe@perches.com" <joe@perches.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "linux-spdx@vger.kernel.org" <linux-spdx@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Kuno Woudt <kuno@frob.nl>,
        "copyleft-next@lists.fedorahosted.org" 
        <copyleft-next@lists.fedorahosted.org>,
        Ciaran Farrell <Ciaran.Farrell@suse.com>,
        Christopher De Nicolo <Christopher.DeNicolo@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v9 1/6] LICENSES: Add the copyleft-next-0.3.1 license
Message-ID: <Yo6HC9BfkCo3MBbH@bombadil.infradead.org>
References: <20211029184500.2821444-1-mcgrof@kernel.org>
 <20211029184500.2821444-2-mcgrof@kernel.org>
 <87bkvo0wjd.ffs@tglx>
 <Yo5cxWghV/v2Fnzf@bombadil.infradead.org>
 <BN7PR13MB24998CAFCFB973C80549F308FDD69@BN7PR13MB2499.namprd13.prod.outlook.com>
 <Yo5xTwGLmbsgJhfM@bombadil.infradead.org>
 <BN7PR13MB2499BA2AFAC1C79197734D81FDD69@BN7PR13MB2499.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN7PR13MB2499BA2AFAC1C79197734D81FDD69@BN7PR13MB2499.namprd13.prod.outlook.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 25, 2022 at 07:05:31PM +0000, Bird, Tim wrote:
> > -----Original Message-----
> > From: Luis Chamberlain <mcgrof@infradead.org> On Behalf Of Luis Chamberlain
> > 
> > On Wed, May 25, 2022 at 05:05:54PM +0000, Bird, Tim wrote:
> > > I know it's being submitted as an OR, but I question
> > > the value of introducing another license into the kernel's licensing mix.
> > 
> > I agree that we want to keep the number of licenses as small as
> > possible but we cannot really dictate which dual licensing options a
> > submitter selects unless the license is GPL-2.0-only incompatible,
> > which copyleft-next is not.
> 
> Um, yes we can dictate that. 

The statement about us not being able to dictate which dual licensing
options a submitter selects does not actually come from me, Thomas noted
this [0].

[0] https://lkml.kernel.org/r/87fsl1iqg0.ffs@tglx

> There were good reasons that the original
> BSD dual-licenses were allowed.

I helped spearhead some of that effort.

> Those same reasons don't apply here.

Correct, and I noted my own reasoning for now dual licensing with
copyleft-next, which you seem to be disregarding?

> Each license added to the kernel (even when added as an OR), requires
> additional legal analysis.

And I noted in my cover letter that copyleft-next-0.3.1 has been found to be
to be GPLv2 compatible by three attorneys at SUSE and Redhat [1], but
to err on the side of caution we simply recommend to always use the "OR"
language for this license [2].

[1] https://lore.kernel.org/lkml/20170516232702.GL17314@wotan.suse.de/
[2] https://lkml.kernel.org/r/1495234558.7848.122.camel@linux.intel.com

> And here's the thing.
> The copyleft-next license has a number of legal issues that make it problematic.

You say number of legal issues.

> Not the least of which are that some of its terms are dependent on external
> situations that can change over time, in a matter that is uncontrolled by either
> the licensor or the licensee.  In order to determine what terms are effective, you
> have to know when the license was granted, and what the FSF and OSI approved
> licenses were at various points in time.  You literally have to use the Internet
> Archive wayback machine, and do a bunch of research, to interpret the license terms.
> It is not, as currently constructed, a good license, due to this lack of legal clarity.

But the above seems to indicate one technical pain point in so far as
two sections:

4. Condition Against Further Restrictions; Inbound License Compatibility
7. Nullification of Copyleft/Proprietary Dual Licensing

If you are going to offer to pay for an alternative proprietary
licensing, I'm sure you can do the work.

And if in so far as clause 4 is concerned, yeah I think wayback machine
is a sensible solution. Good idea, seems like we have that covered since
1999 [3].

[3] https://web.archive.org/web/*/https://opensource.org/licenses

  Luis
