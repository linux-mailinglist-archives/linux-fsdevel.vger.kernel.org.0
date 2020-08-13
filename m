Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC23243BFF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 16:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgHMO4W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 10:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgHMO4V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 10:56:21 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B79CC061757;
        Thu, 13 Aug 2020 07:56:21 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id q14so5773814ilj.8;
        Thu, 13 Aug 2020 07:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=h86jHgXoGDrr6y1H8GyRJonT43XDQUGwHsyIjrhVClo=;
        b=B+mU/7AA7XkCB/WQIaZ0Uw35rHqx3FZlWfVE1DyqFdBseBLhVBC2WXmEUnX3bL16N8
         hifCnG0SzU/B3z/g5mM/0gMgqgHnAOEjMlQVmeIU8eE+dQ6csS+IMG8Gl/UoKYRJREj6
         NQ4WjR5wKqRWsM3czQOCG90hF1K6Vx45EDKHGAqlVH3bzn/7iiCVMJ09eMdZYto61Iui
         Vtv0Zo2FsoOleYy80RSEuRQZhxjh3nvjgxT3tiEqpHB0ywRU2SsawHnqZmvn2Mb98EY6
         y1DRK8Kp2eDEvN1Majj+vLY0Sex6QY6W/VvqHhrl1HUG2iimWg4iqdfx6vtZu8hHHSPT
         us9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=h86jHgXoGDrr6y1H8GyRJonT43XDQUGwHsyIjrhVClo=;
        b=Hrgnrvd08hwLM9g34ydyyhGTRXG0lkxFKWCdE8ozC5KkLeAROJHE9qCwoeDBjhnCqL
         bJHI0xU7unN68le6mKH+y77BMbXLI6x/qkQBuXCSkGkt6498bxAnf9LZ24kPHPetPvX4
         5ll7rNEnsKJFOXKnlIZMfMebEls5NXIpRln/url6AwWXY4MdLbUOoFVeZwOqdvo6TtDv
         I/TpENCZRo7isiT93nvExlWMfZuQdIpnzQoSTgbGkwh0HP5dFEU1ohhcYfVzw80N/fqj
         e17Kg2Klhl335IboOTeWiU3TkmPcWjKTo650AAgURH5ucOE4d6C1Wjhzz74dLU8M5/4y
         7ioA==
X-Gm-Message-State: AOAM533WqLk0n1rs6aYFsHnUng+6GKJmBPiPyWkJedStOVa7TMasN6Fe
        LVGB3PiitBnwVab5wvKlzEA=
X-Google-Smtp-Source: ABdhPJyufAWBDkWl0rbFsm4iCNiuMOHAC/vQfunIPsTD3bDPGN/H0DAGcWooZcr1d23PB42mHpq9Dw==
X-Received: by 2002:a92:99ca:: with SMTP id t71mr2876299ilk.143.1597330580641;
        Thu, 13 Aug 2020 07:56:20 -0700 (PDT)
Received: from anon-dhcp-152.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id p13sm2089843ilb.61.2020.08.13.07.56.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2020 07:56:19 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [dm-devel] [RFC PATCH v5 00/11] Integrity Policy Enforcement LSM
 (IPE)
From:   Chuck Lever <chucklever@gmail.com>
In-Reply-To: <1597329763.3708.13.camel@HansenPartnership.com>
Date:   Thu, 13 Aug 2020 10:56:17 -0400
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
Content-Transfer-Encoding: quoted-printable
Message-Id: <49A45475-20D8-456E-92AD-F63DBC71F900@gmail.com>
References: <20200728213614.586312-1-deven.desai@linux.microsoft.com>
 <20200802115545.GA1162@bug> <20200802140300.GA2975990@sasha-vm>
 <20200802143143.GB20261@amd> <1596386606.4087.20.camel@HansenPartnership.com>
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
 <1597170509.4325.55.camel@HansenPartnership.com>
 <2CA41152-6445-4716-B5EE-2D14E5C59368@gmail.com>
 <1597246946.7293.9.camel@HansenPartnership.com>
 <3F328A12-25DD-418B-A7D0-64DA09236E1C@gmail.com>
 <1597329763.3708.13.camel@HansenPartnership.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Aug 13, 2020, at 10:42 AM, James Bottomley =
<James.Bottomley@HansenPartnership.com> wrote:
>=20
> On Thu, 2020-08-13 at 10:21 -0400, Chuck Lever wrote:
>>> On Aug 12, 2020, at 11:42 AM, James Bottomley <James.Bottomley@Hans
>>> enPartnership.com> wrote:
> [...]
>>> For most people the security mechanism of local xattrs is
>>> sufficient.  If you're paranoid, you don't believe it is and you
>>> use EVM.
>>=20
>> When IMA metadata happens to be stored in local filesystems in
>> a trusted xattr, it's going to enjoy the protection you describe
>> without needing the addition of a cryptographic signature.
>>=20
>> However, that metadata doesn't live its whole life there. It
>> can reside in a tar file, it can cross a network, it can live
>> on a back-up tape. I think we agree that any time that metadata
>> is in transit or at rest outside of a Linux local filesystem, it
>> is exposed.
>>=20
>> Thus I'm interested in a metadata protection mechanism that does
>> not rely on the security characteristics of a particular storage
>> container. For me, a cryptographic signature fits that bill
>> nicely.
>=20
> Sure, but one of the points about IMA is a separation of mechanism =
from
> policy.  Signed hashes (called appraisal in IMA terms) is just one
> policy you can decide to require or not or even make it conditional on
> other things.

AFAICT, the current EVM_IMA_DIGSIG and EVM_PORTABLE_DIGSIG formats are
always signed. The policy choice is whether or not to verify the
signature, not whether or not the metadata format is signed.


--
Chuck Lever
chucklever@gmail.com



