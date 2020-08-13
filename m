Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700B92432EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 05:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgHMDpK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 23:45:10 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:56871 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726334AbgHMDpK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 23:45:10 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.west.internal (Postfix) with ESMTP id 14D72FC9;
        Wed, 12 Aug 2020 23:45:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 12 Aug 2020 23:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        riEkJBk9dtTCMdsd2KuRcCF6pt/EtfYew54yr6yCdJ0=; b=KzEjKotH5i2EDTcj
        kvBpYZ5LOAFPB3zMvzFYCfj8QWTdLQM6ENrhOYMHVPnS/e1YFPtX5i0OPsSeL4ru
        PvwvOAY2wvRAwmRget9I0dt/a1ke9rAouh2Wgi2a1F19YRdQe3xFr0skY7v9g6xp
        YWkG5uEGTHHDSHw749P3caLQRxi2dSKsT9mKL9i2Lic5SF4/V2/qd6SyDloKKpzn
        mC3Mz1GgSqOEtMZUFV4s6SCZeHuu0eWGZAhz+kwbNCNU4scom7ETFIfALUgxvfGB
        4kPIYmLPdrtA1QtIDzQ87SzdCUe+OvdLZADloyG/TQvZRy86RDL6cxypjy6IGbit
        yROLsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=riEkJBk9dtTCMdsd2KuRcCF6pt/EtfYew54yr6yCd
        J0=; b=Y5xPbwpSaJE7r6+Mg7K2AJQddMRP2uXhV5YS+cJGQmJF5qa1oXZGzN/k1
        R+socj+BfnH/JFqfoZm4RiPdIMOgXWYE6bTDevZjmItShA7NGhZdEh9jJOoXfNqp
        2yzFqbjNKqvPDhkbD3GePGpxGZSVtFCDuaclNV3rhg96gmwn8q8fWGShLUVdaCuS
        uhmTKmhH948l8vmP+bRPZ02NjzV6Vql+G7EGt5vcxSLvxO16Ux/y16XqZvvCUfhD
        N298oO9RFrzp6hhtvgm8BA6PUVN5RDvNlbJ9f7FFe9hgXO3p7ypNkJp4gXM/+jwH
        0t2/59pboQs6CDp7CZCrcdb3IrctQ==
X-ME-Sender: <xms:Qrc0X8Lc1yZIEPskEWLBeDxIuetSBLIxdPQ6GpEA1g7a2j3loMUpZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrleefgdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    efteetvdeguddvveefveeftedtffduudehueeihfeuvefgveehffeludeggfejnecukfhp
    peehkedrjedrvddtfedruddugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:Qrc0X8JmDYFlSNcZKK2nszokJSpdOioE1XPHpaqoyty_dHf6SuSp7Q>
    <xmx:Qrc0X8tkP-vChz8GV1z1A9ihiy8aqTa6b_5PBYaV7Fix_HUT3C6GRg>
    <xmx:Qrc0X5a4k1gagaBZVNG52KO4BnXvOZwG_cOsYiNF5ppt2zi0xteFIA>
    <xmx:Q7c0XwQsbzSGPz00inTTQlqYeTpp31KU-MhIhYYisLYqmKnYMTSOyrVk97A>
Received: from mickey.themaw.net (58-7-203-114.dyn.iinet.net.au [58.7.203.114])
        by mail.messagingengine.com (Postfix) with ESMTPA id BA4CC306005F;
        Wed, 12 Aug 2020 23:44:58 -0400 (EDT)
Message-ID: <20a60b5984a7f6e3e7d351b789c0b0beedfb2653.camel@themaw.net>
Subject: Re: file metadata via fs API
From:   Ian Kent <raven@themaw.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Whitehouse <swhiteho@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 13 Aug 2020 11:44:54 +0800
In-Reply-To: <CAHk-=wgz5H-xYG4bOrHaEtY7rvFA1_6+mTSpjrgK8OsNbfF+Pw@mail.gmail.com>
References: <1842689.1596468469@warthog.procyon.org.uk>
         <1845353.1596469795@warthog.procyon.org.uk>
         <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
         <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
         <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
         <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
         <20200811135419.GA1263716@miu.piliscsaba.redhat.com>
         <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
         <52483.1597190733@warthog.procyon.org.uk>
         <CAHk-=wiPx0UJ6Q1X=azwz32xrSeKnTJcH8enySwuuwnGKkHoPA@mail.gmail.com>
         <066f9aaf-ee97-46db-022f-5d007f9e6edb@redhat.com>
         <CAHk-=wgz5H-xYG4bOrHaEtY7rvFA1_6+mTSpjrgK8OsNbfF+Pw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-08-12 at 12:50 -0700, Linus Torvalds wrote:
> On Wed, Aug 12, 2020 at 12:34 PM Steven Whitehouse <
> swhiteho@redhat.com> wrote:
> > The point of this is to give us the ability to monitor mounts from
> > userspace.
> 
> We haven't had that before, I don't see why it's suddenly such a big
> deal.

Because there's a trend occurring in user space where there are
frequent and persistent mount changes that cause high overhead.

I've seen the number of problems building up over the last few months
that are essentially the same problem that I wanted to resolve. And
that's related to side effects of autofs using a large number of
mounts.

The problems are real.

> 
> The notification side I understand. Polling /proc files is not the
> answer.

Yep, that's one aspect, getting the information about a mount without
reading the entire mount table seems like the sensible thing to do to
allow for a more efficient notification mechanism.

> 
> But the whole "let's design this crazy subsystem for it" seems way
> overkill. I don't see anybody caring that deeply.
> 
> It really smells like "do it because we can, not because we must".
> 
> Who the hell cares about monitoring mounts at a kHz frequencies? If
> this is for MIS use, you want a nice GUI and not wasting CPU time
> polling.

That part of the problem still remains.

The kernel sending a continuous stream of wake ups under load does
also introduce a resource problem but that's probably something to
handle in user space.

> 
> I'm starting to ignore the pull requests from David Howells, because
> by now they have had the same pattern for a couple of years now:
> esoteric new interfaces that seem overdesigned for corner-cases that
> I'm not seeing people clamoring for.
> 
> I need (a) proof this is actualyl something real users care about and
> (b) way more open discussion and implementation from multiple
> parties.
> 
> Because right now it looks like a small in-cabal of a couple of
> people
> who have wild ideas but I'm not seeing the wider use of it.
> 
> Convince me otherwise. AGAIN. This is the exact same issue I had with
> the notification queues that I really wanted actual use-cases for,
> and
> feedback from actual outside users.
> 
> I really think this is engineering for its own sake, rather than
> responding to actual user concerns.
> 
>                Linus

