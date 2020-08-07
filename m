Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A96F23F1F6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 19:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgHGRce (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 13:32:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36432 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726015AbgHGRcc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 13:32:32 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 077HW45O185756;
        Fri, 7 Aug 2020 13:32:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Y0pKoWPeTxDyByUmLaCIWxPyH2WwR9p+/RxajWERAWo=;
 b=jd8bvtZSDyNgHw2Je8MeB+DJ4XXI9Pf45pkFwoUx+CqF1AgoBovcIE+mumIY79vc5bTf
 ns67M1Y+8W/AAFJVuVwsN1g6c6nDdNKYVu5ajSLIuEn93EDoAhq1n1CS0UncjvpDTClo
 5/x4R8oSQrERkaRuVked3eDOR7kBxPGZbecpNpVdtwXsNTH/Z18WO4VIoVhaBhZsNgOH
 FbdQnOsCLbFjtWEZKnAjCmqvdBLzrhV6OnvzBoLfO+5Pp+EWgl2OmrR0atXyOKhl3zX5
 TGxtNZnfzXB0sK9P697OG2ojYwvTemmIMHOC5k/zgGasURdGSMvfxvc6Ucxm81nnQtXC xA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32repj1gev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Aug 2020 13:32:07 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 077HW4kl185730;
        Fri, 7 Aug 2020 13:32:06 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32repj1g73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Aug 2020 13:32:06 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 077HVYj4008226;
        Fri, 7 Aug 2020 17:31:34 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 32nyyd3e91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Aug 2020 17:31:34 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 077HVVF530343660
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Aug 2020 17:31:31 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFFE252050;
        Fri,  7 Aug 2020 17:31:31 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.122.187])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 004F55204F;
        Fri,  7 Aug 2020 17:31:27 +0000 (GMT)
Message-ID: <4a764c86a824a4b931dd7f130ce7afce7df140e4.camel@linux.ibm.com>
Subject: Re: [dm-devel] [RFC PATCH v5 00/11] Integrity Policy Enforcement
 LSM (IPE)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     James Morris <jmorris@namei.org>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
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
Date:   Fri, 07 Aug 2020 13:31:27 -0400
In-Reply-To: <alpine.LRH.2.21.2008080240350.13040@namei.org>
References: <20200728213614.586312-1-deven.desai@linux.microsoft.com>
                   <20200802115545.GA1162@bug> <20200802140300.GA2975990@sasha-vm>
                   <20200802143143.GB20261@amd>
                   <1596386606.4087.20.camel@HansenPartnership.com>
                   <fb35a1f7-7633-a678-3f0f-17cf83032d2b@linux.microsoft.com>
                 <1596639689.3457.17.camel@HansenPartnership.com>
                  <alpine.LRH.2.21.2008050934060.28225@namei.org>
                 <b08ae82102f35936427bf138085484f75532cff1.camel@linux.ibm.com>
                 <alpine.LRH.2.21.2008060949410.20084@namei.org>
         <eb7a2f5b5cd22cf9231aa0fd8fdb77c729a83428.camel@linux.ibm.com>
         <alpine.LRH.2.21.2008080240350.13040@namei.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-07_15:2020-08-06,2020-08-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 clxscore=1015 phishscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008070120
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2020-08-08 at 02:41 +1000, James Morris wrote:
> On Thu, 6 Aug 2020, Mimi Zohar wrote:
> 
> > On Thu, 2020-08-06 at 09:51 +1000, James Morris wrote:
> > > On Wed, 5 Aug 2020, Mimi Zohar wrote:
> > > 
> > > > If block layer integrity was enough, there wouldn't have been a need
> > > > for fs-verity.   Even fs-verity is limited to read only filesystems,
> > > > which makes validating file integrity so much easier.  From the
> > > > beginning, we've said that fs-verity signatures should be included in
> > > > the measurement list.  (I thought someone signed on to add that support
> > > > to IMA, but have not yet seen anything.)
> > > > 
> > > > Going forward I see a lot of what we've accomplished being incorporated
> > > > into the filesystems.  When IMA will be limited to defining a system
> > > > wide policy, I'll have completed my job.
> > > 
> > > What are your thoughts on IPE being a standalone LSM? Would you prefer to 
> > > see its functionality integrated into IMA?
> > 
> > Improving the integrity subsystem would be preferred.
> > 
> 
> Are you planning to attend Plumbers? Perhaps we could propose a BoF 
> session on this topic.

That sounds like a good idea.

Mimi


