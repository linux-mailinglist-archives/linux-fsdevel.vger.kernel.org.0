Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0AE23CE21
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 20:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbgHESQY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Aug 2020 14:16:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33162 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728665AbgHESPy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Aug 2020 14:15:54 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 075I6IQw022319;
        Wed, 5 Aug 2020 14:15:30 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32qtnq5s5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Aug 2020 14:15:30 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 075I6SBw023318;
        Wed, 5 Aug 2020 14:15:29 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32qtnq5s4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Aug 2020 14:15:29 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 075IAP9d012198;
        Wed, 5 Aug 2020 18:15:27 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 32n018au5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Aug 2020 18:15:27 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 075IFOpu33489240
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Aug 2020 18:15:25 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDB2EAE051;
        Wed,  5 Aug 2020 18:15:24 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42453AE055;
        Wed,  5 Aug 2020 18:15:19 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.95.205])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  5 Aug 2020 18:15:19 +0000 (GMT)
Message-ID: <b08ae82102f35936427bf138085484f75532cff1.camel@linux.ibm.com>
Subject: Re: [dm-devel] [RFC PATCH v5 00/11] Integrity Policy Enforcement
 LSM (IPE)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     James Morris <jmorris@namei.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Deven Bowers <deven.desai@linux.microsoft.com>,
        Pavel Machek <pavel@ucw.cz>, Sasha Levin <sashal@kernel.org>,
        snitzer@redhat.com, dm-devel@redhat.com,
        tyhicks@linux.microsoft.com, agk@redhat.com, paul@paul-moore.com,
        corbet@lwn.net, nramas@linux.microsoft.com, serge@hallyn.com,
        pasha.tatashin@soleen.com, jannh@google.com,
        linux-block@vger.kernel.org, viro@zeniv.linux.org.uk,
        axboe@kernel.dk, mdsakib@microsoft.com,
        linux-kernel@vger.kernel.org, eparis@redhat.com,
        linux-security-module@vger.kernel.org, linux-audit@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jaskarankhurana@linux.microsoft.com
Date:   Wed, 05 Aug 2020 14:15:13 -0400
In-Reply-To: <alpine.LRH.2.21.2008050934060.28225@namei.org>
References: <20200728213614.586312-1-deven.desai@linux.microsoft.com>
          <20200802115545.GA1162@bug> <20200802140300.GA2975990@sasha-vm>
          <20200802143143.GB20261@amd>
          <1596386606.4087.20.camel@HansenPartnership.com>
          <fb35a1f7-7633-a678-3f0f-17cf83032d2b@linux.microsoft.com>
         <1596639689.3457.17.camel@HansenPartnership.com>
         <alpine.LRH.2.21.2008050934060.28225@namei.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-05_14:2020-08-03,2020-08-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 phishscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxscore=0 impostorscore=0
 clxscore=1011 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008050141
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-08-05 at 09:59 -0700, James Morris wrote:
> On Wed, 5 Aug 2020, James Bottomley wrote:
> 
> > I'll leave Mimi to answer, but really this is exactly the question that
> > should have been asked before writing IPE.  However, since we have the
> > cart before the horse, let me break the above down into two specific
> > questions.
> 
> The question is valid and it was asked. We decided to first prototype what 
> we needed and then evaluate if it should be integrated with IMA. We 
> discussed this plan in person with Mimi (at LSS-NA in 2019), and presented 
> a more mature version of IPE to LSS-NA in 2020, with the expectation that 
> such a discussion may come up (it did not).

When we first spoke the concepts weren't fully formulated, at least to
me.
> 
> These patches are still part of this process and 'RFC' status.
> 
> >    1. Could we implement IPE in IMA (as in would extensions to IMA cover
> >       everything).  I think the answers above indicate this is a "yes".
> 
> It could be done, if needed.
> 
> >    2. Should we extend IMA to implement it?  This is really whether from a
> >       usability standpoint two seperate LSMs would make sense to cover the
> >       different use cases.
> 
> One issue here is that IMA is fundamentally a measurement & appraisal 
> scheme which has been extended to include integrity enforcement. IPE was 
> designed from scratch to only perform integrity enforcement. As such, it 
> is a cleaner design -- "do one thing and do it well" is a good design 
> pattern.
> 
> In our use-case, we utilize _both_ IMA and IPE, for attestation and code 
> integrity respectively. It is useful to be able to separate these 
> concepts. They really are different:
> 
> - Code integrity enforcement ensures that code running locally is of known 
> provenance and has not been modified prior to execution.
> 
> - Attestation is about measuring the health of a system and having that 
> measurement validated by a remote system. (Local attestation is useless).
> 
> I'm not sure there is value in continuing to shoe-horn both of these into 
> IMA.

True, IMA was originally limited to measurement and attestation, but
most of the original EVM concepts were subsequently included in IMA. 
(Remember, Reiner Sailer wrote the original IMA, which I inherited.  I
was originially working on EVM code integrity.)  From a naming
perspective including EVM code integrity in IMA was a mistake.  My
thinking at the time was that as IMA was already calculating the file
hash, instead of re-calculating the file hash for integrity, calculate
the file hash once and re-use it for multiple things - measurement, 
integrity, and audit.   At the same time define a single system wide
policy.

When we first started working on IMA, EVM, trusted, and encrypted keys,
the general kernel community didn't see a need for any of it.  Thus, a
lot of what was accomplished has been accomplished without the backing
of the real core filesystem people.

If block layer integrity was enough, there wouldn't have been a need
for fs-verity.   Even fs-verity is limited to read only filesystems,
which makes validating file integrity so much easier.  From the
beginning, we've said that fs-verity signatures should be included in
the measurement list.  (I thought someone signed on to add that support
to IMA, but have not yet seen anything.)

Going forward I see a lot of what we've accomplished being incorporated
into the filesystems.  When IMA will be limited to defining a system
wide policy, I'll have completed my job.

Mimi

> 
> >  I've got to say the least attractive thing
> >       about separation is the fact that you now both have a policy parser.
> >        You've tried to differentiate yours by making it more Kconfig
> >       based, but policy has a way of becoming user space supplied because
> >       the distros hate config options, so I think you're going to end up
> >       with a policy parser very like IMAs.


