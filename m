Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA34A17C61C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 20:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgCFTPz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 14:15:55 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:57856 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726167AbgCFTPy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 14:15:54 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id EC3F78EE11D;
        Fri,  6 Mar 2020 11:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1583522154;
        bh=/OfiD8pxTy0cgbbgHjCoeXz2owVNFIiY43G+wjReSfw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=PU0dR+Erm3kVlerDUdH+FYaWPWMZ7wSzQCCUznWsyQOXnbUkE/KThxQq1+fsIspA2
         mflun5XkW5/9ir3+HIlZEkfXk3cnNsg/eH/NFq/HDbNpcw1vhxlqfYqDGq1jPb9Fkd
         kXh2jZeQEXAU1D9DT/CLYDD3rgTS6pEvuFqfagXU=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AO-2jUBauNPH; Fri,  6 Mar 2020 11:15:53 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 230C78EE0F8;
        Fri,  6 Mar 2020 11:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1583522153;
        bh=/OfiD8pxTy0cgbbgHjCoeXz2owVNFIiY43G+wjReSfw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JUf4tVJEbGPD8RouHJs2vAI2XwHhjBh563uBWSUYP64GyuQGyA2LvfCuzUJ7JAEsT
         PCpGO1WVEjODSm5A03Vjrr6Y04jZl7c8HaE49oUbdWTID+1VVJfqiz1ARiOcpittO0
         bwsOY7KVaOiyDyOGHzrPzyZX4KJKswK9B5NaS20w=
Message-ID: <1583522151.3653.81.camel@HansenPartnership.com>
Subject: Re: [LSFMMBPF TOPIC] Killing LSFMMBPF
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        lsf-pc <lsf-pc@lists.linuxfoundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, bpf@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org
Date:   Fri, 06 Mar 2020 11:15:51 -0800
In-Reply-To: <yq1eeu51ev0.fsf@oracle.com>
References: <b506a373-c127-b92e-9824-16e8267fc910@toxicpanda.com>
         <20200306160548.GB25710@bombadil.infradead.org>
         <1583516279.3653.71.camel@HansenPartnership.com>
         <20200306180618.GN31668@ziepe.ca> <yq1eeu51ev0.fsf@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2020-03-06 at 14:07 -0500, Martin K. Petersen wrote:
> Jason,
> 
> > Yes, I can confirm this from another smaller hotel-style conference
> > I've been involved organizing on occasion. $600-$800 is required to
> > break even without major sponsorship $$ for the ~100 people mark,
> > and that is without the usual food and venue perks we see at
> > plumbers/lsfmm.
> 
> Yep. Our actual per-person cost for LSF/MM/BPF is in excess of $1K.
> That limits who we can invite. Personally I absolutely hate the
> invitation aspect and process. But we are very constrained wrt. how
> many we can actually accommodate by the amount of funding we get.
> Things appear to be better this year, but sponsor mergers and
> acquisitions have been a major concern the past few years.

To be a bit mercenary (hey, it's my job, I'm Plumbers treasurer this
year) our sponsors are mostly the same companies.  If we combine LSF/MM
and Plumbers, I can't see too many of them stepping up to sponsor us
twice, so we'll have a net loss of sponsor funding for the combined
event as well.  This is likely another argument for doing two
separately sponsored events.

James

