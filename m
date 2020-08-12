Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24FE242B30
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 16:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgHLOSq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 10:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgHLOSo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 10:18:44 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B70C061383;
        Wed, 12 Aug 2020 07:18:44 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id 77so1764476ilc.5;
        Wed, 12 Aug 2020 07:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=48IsAeauuq9BcWaKpHbdNQ/tldBG5RElnWagtcAUqV4=;
        b=cRsT2ZGxUqGKOyzMO0wNvu9c+MKHGwNtaL6WtkzcJzG2FycOznSzVRew0E6OYHFgux
         fsIyKPl6ke8ScaAfvjEtSMjX/9nYkikjCzR9HUZnzR8ETeQxqgzT8T9m9tkPZXgOf2rz
         QTa2ibKV/kc3wjS8YgXlIeurfSfb/bDJCAKxjA45Lso2Ku4KDO7jliyJhWJHeEhDFA7X
         ReTwAvAMpfx0ApCdtT50EYjARYNFr2Pa0x4ybb5B05UqDaqofUj0hJUWtxBZFJZPdZOq
         VTjf/jf3xqOmYG2RwMDDkJTrdk7iPHgg2+DhSezRHe/5imOjPJK1QaINlGCpBwHoXiux
         1TmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=48IsAeauuq9BcWaKpHbdNQ/tldBG5RElnWagtcAUqV4=;
        b=jDAFX//wlZ67ADG3BRoc+98oHpeUn1PkrsX26dCVeGKDRRPBup3obeJAuaOiYMIbCR
         a9iWZ1Ixmd4rKaYTO9a7qUhqRuy3y/hE/klwkuoTnXP38yhvxernDptdOOZ/OPAObcZ0
         6VG3d2Xx91WoPNA+E1zpCGTYV3490uFcffflct3GLTVVramOjjnfUfq1HKBva40INeWV
         50Qt5h+zszbG5bX2ZM20lLfWXJQzKKtx2iSdyb04CCbjo/lAkVceldBJ4a4gTDdKCafk
         OuMbd7Wnc/zmu9QEkRuXBCUzVDH2U2jDp6MohoIFcy870Fj1QYhk9LibeVcL82uf/WQ3
         hayA==
X-Gm-Message-State: AOAM532wUN5rEwsWt789RLQyCVJRltRw3Tr8BCd2LgsN6EC6lldeZk7T
        ApzeZzY2nQkFsclluTDHq60=
X-Google-Smtp-Source: ABdhPJzf/jasvT0zc9p1+CGDgqywSS+wUi9D5ewUAR1wjx5vZ+7v7igbj00P+ikLT5qiFiGJ2YZ2iA==
X-Received: by 2002:a92:418b:: with SMTP id o133mr14743047ila.277.1597241924157;
        Wed, 12 Aug 2020 07:18:44 -0700 (PDT)
Received: from anon-dhcp-152.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id r8sm1129252ilt.54.2020.08.12.07.18.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Aug 2020 07:18:42 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [dm-devel] [RFC PATCH v5 00/11] Integrity Policy Enforcement LSM
 (IPE)
From:   Chuck Lever <chucklever@gmail.com>
In-Reply-To: <alpine.LRH.2.21.2008120643370.10591@namei.org>
Date:   Wed, 12 Aug 2020 10:18:41 -0400
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
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
Content-Transfer-Encoding: 7bit
Message-Id: <70603A4E-A548-4ECB-97D4-D3102CE77701@gmail.com>
References: <20200728213614.586312-1-deven.desai@linux.microsoft.com>
 <20200802115545.GA1162@bug> <20200802140300.GA2975990@sasha-vm>
 <20200802143143.GB20261@amd> <1596386606.4087.20.camel@HansenPartnership.com>
 <fb35a1f7-7633-a678-3f0f-17cf83032d2b@linux.microsoft.com>
 <1596639689.3457.17.camel@HansenPartnership.com>
 <alpine.LRH.2.21.2008050934060.28225@namei.org>
 <b08ae82102f35936427bf138085484f75532cff1.camel@linux.ibm.com>
 <329E8DBA-049E-4959-AFD4-9D118DEB176E@gmail.com>
 <alpine.LRH.2.21.2008120643370.10591@namei.org>
To:     James Morris <jmorris@namei.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Aug 11, 2020, at 5:03 PM, James Morris <jmorris@namei.org> wrote:
> 
> On Sat, 8 Aug 2020, Chuck Lever wrote:
> 
>> My interest is in code integrity enforcement for executables stored
>> in NFS files.
>> 
>> My struggle with IPE is that due to its dependence on dm-verity, it
>> does not seem to able to protect content that is stored separately
>> from its execution environment and accessed via a file access
>> protocol (FUSE, SMB, NFS, etc).
> 
> It's not dependent on DM-Verity, that's just one possible integrity 
> verification mechanism, and one of two supported in this initial 
> version. The other is 'boot_verified' for a verified or otherwise trusted 
> rootfs. Future versions will support FS-Verity, at least.
> 
> IPE was designed to be extensible in this way, with a strong separation of 
> mechanism and policy.

I got that, but it looked to me like the whole system relied on having
access to the block device under the filesystem. That's not possible
for a remote filesystem like Ceph or NFS.

I'm happy to take a closer look if someone can point me the right way.


--
Chuck Lever
chucklever@gmail.com



