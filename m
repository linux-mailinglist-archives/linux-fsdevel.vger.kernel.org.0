Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 445CF17CFC6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Mar 2020 20:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgCGTMW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Mar 2020 14:12:22 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:48764 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726116AbgCGTMV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Mar 2020 14:12:21 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D37C58EE0FD;
        Sat,  7 Mar 2020 11:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1583608340;
        bh=OTExqST3EIQqKYzie7fnIaR9F29Rbki864Xhub7443Q=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lILO1w8M5X5MwVyf0UEV37EwwviKKsvMyy4/5iphxqtCwYMOHDpAIjCX1N3HBcACW
         paVYE2nnpzAA6emW6A2rS2m1Ngr4nuk0SD5mL3oP0zYojh+pQUZsbn82C/A2ycnNej
         EUvA3YXNlXdt1T6udIPdWAR2Rz05afODy1IufW54=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jvVAu3loizWQ; Sat,  7 Mar 2020 11:12:20 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E099B8EE0D7;
        Sat,  7 Mar 2020 11:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1583608340;
        bh=OTExqST3EIQqKYzie7fnIaR9F29Rbki864Xhub7443Q=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lILO1w8M5X5MwVyf0UEV37EwwviKKsvMyy4/5iphxqtCwYMOHDpAIjCX1N3HBcACW
         paVYE2nnpzAA6emW6A2rS2m1Ngr4nuk0SD5mL3oP0zYojh+pQUZsbn82C/A2ycnNej
         EUvA3YXNlXdt1T6udIPdWAR2Rz05afODy1IufW54=
Message-ID: <1583608338.20291.28.camel@HansenPartnership.com>
Subject: Re: [LSFMMBPF TOPIC] LSFMMBPF 2020 COVID-19 status update
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        lsf-pc <lsf-pc@lists.linuxfoundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, bpf@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org
Date:   Sat, 07 Mar 2020 11:12:18 -0800
In-Reply-To: <20200307185420.GG2236@42.do-not-panic.com>
References: <b506a373-c127-b92e-9824-16e8267fc910@toxicpanda.com>
         <20200306155611.GA167883@mit.edu>
         <20200307185420.GG2236@42.do-not-panic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2020-03-07 at 18:54 +0000, Luis Chamberlain wrote:
> On Fri, Mar 06, 2020 at 10:56:11AM -0500, Theodore Y. Ts'o wrote:
> > Should we have LSF/MM/BPF in 2020 and COVID-19?
[...]
> If we have to learn from efforts required to continue on with the in
> light of the risks, we can look at what SCALE 18 is doing, taking
> place right now in Pasadena [1], their page lists a list of proactive
> measures required on their part to help alleviate fears and just good
> best practices at this point in time.

I agree Scale18x is the poster child for following WHO advice to the
letter, but there are crucial differences:

   1. Scale18x has a lot of local attendees, so the conference can go
      ahead somewhat easily with local content and local attendees.  We
      have no-one for LSF/MM/BPF in Palm Springs.
   2. Scale18x did have some issues with non-local content because of
      corporate travel bans.  The whole of LSF/MM/BPF is non-local content
      and would thus be significantly disrupted.

The big problem with 2. is that a lot of corporate policies at the
moment are unconsidered blanket bans.  Even corporations who do
consider better might still be stricter than the WHO advice.  So my
company, IBM, is saying events >1000 cancel and events <1000 use your
own discretion provided they're promising to obey all the health
guidelines.  If I'd been presenting at Scale18x I'd have had to cancel,
even though under our guidelines I can still go to LSF/MM/BPF

> The landscape seems positive, if we want, to move forward in Palm
> Springs then.

For a counter example, just look at the LF Member summit which was due
to happen just after Scale18x:

https://events.linuxfoundation.org/lf-member-summit/

and that's a smaller event than Scale18x.  Remember too that the LF
runs LSF/MM so if they decide to cancel, there's not much the
organizing committee can do about it.

James

