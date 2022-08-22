Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FF459C52C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Aug 2022 19:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236971AbiHVRkB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 13:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235360AbiHVRkA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 13:40:00 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815B73F332;
        Mon, 22 Aug 2022 10:39:59 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MGBj1W017156;
        Mon, 22 Aug 2022 17:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=LLQbnt0q20UFDDZ3yGUxRCh9F6rYZEakZkSemAYNDz0=;
 b=l4O2LQ4b+48Y2b5DbW1GS09Ly8JzaBLZaS0gBXC3VkjUvj/hldFY/Qgn/oEPAkVT931f
 0FtS6g4/KYfkctQgTvxXRaWg2HEovJYovqd2qKF0VsL+H/7qHI2yyqi1ba3gQD1KOpFe
 IOrL04i+ZG/G6CAwfz/CXa1uqK5mZ1sBUmzXSb8oxyLdL1M+T9heR6Z1QjnvQj/lr1+u
 EdD7vu8CTN/RxHtMHgQB/P8OwRhpQlKZ6dNxJHoxvvvgtDXA7mYNruOMLf9cgJAa/ICs
 N4gM94Kcgpb7wf4gtC65YOsHEdOwp3DT4z1GVvjDSgqOp+iuGVNfB8znjSezdAu5USsO tg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j4d3w2gax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Aug 2022 17:39:51 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27MHLM14021957;
        Mon, 22 Aug 2022 17:39:48 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3j2q88tqnt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Aug 2022 17:39:48 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27MHe62F33751454
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 17:40:06 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78A05A404D;
        Mon, 22 Aug 2022 17:39:46 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CADB0A4040;
        Mon, 22 Aug 2022 17:39:43 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.163.20.129])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 22 Aug 2022 17:39:43 +0000 (GMT)
Message-ID: <18827b350fbf6719733fda814255ec20d6dcf00f.camel@linux.ibm.com>
Subject: Re: [PATCH] iversion: update comments with info about atime updates
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, NeilBrown <neilb@suse.de>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Dave Chinner <david@fromorbit.com>
Date:   Mon, 22 Aug 2022 13:39:42 -0400
In-Reply-To: <f17b9d627703bee2a7b531a051461671648a9dbd.camel@kernel.org>
References: <20220822133309.86005-1-jlayton@kernel.org>
         <ceb8f09a4cb2de67f40604d03ee0c475feb3130a.camel@linux.ibm.com>
         <f17b9d627703bee2a7b531a051461671648a9dbd.camel@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DPsvjf5TeA-4Aml2sZxqU_iiU1YlCmIP
X-Proofpoint-ORIG-GUID: DPsvjf5TeA-4Aml2sZxqU_iiU1YlCmIP
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_10,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 spamscore=0 clxscore=1015
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2208220073
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2022-08-22 at 12:22 -0400, Jeff Layton wrote:
> On Mon, 2022-08-22 at 11:40 -0400, Mimi Zohar wrote:
> > On Mon, 2022-08-22 at 09:33 -0400, Jeff Layton wrote:
> > > Add an explicit paragraph codifying that atime updates due to reads
> > > should not be counted against the i_version counter. None of the
> > > existing subsystems that use the i_version want those counted, and
> > > there is an easy workaround for those that do.
> > > 
> > > Cc: NeilBrown <neilb@suse.de>
> > > Cc: Trond Myklebust <trondmy@hammerspace.com>
> > > Cc: Dave Chinner <david@fromorbit.com>
> > > Link: https://lore.kernel.org/linux-xfs/166086932784.5425.17134712694961326033@noble.neil.brown.name/#t
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  include/linux/iversion.h | 10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/include/linux/iversion.h b/include/linux/iversion.h
> > > index 3bfebde5a1a6..da6cc1cc520a 100644
> > > --- a/include/linux/iversion.h
> > > +++ b/include/linux/iversion.h
> > > @@ -9,8 +9,8 @@
> > >   * ---------------------------
> > >   * The change attribute (i_version) is mandated by NFSv4 and is mostly for
> > >   * knfsd, but is also used for other purposes (e.g. IMA). The i_version must
> > > - * appear different to observers if there was a change to the inode's data or
> > > - * metadata since it was last queried.
> > > + * appear different to observers if there was an explicit change to the inode's
> > > + * data or metadata since it was last queried.
> > >   *
> > >   * Observers see the i_version as a 64-bit number that never decreases. If it
> > >   * remains the same since it was last checked, then nothing has changed in the
> > > @@ -18,6 +18,12 @@
> > >   * anything about the nature or magnitude of the changes from the value, only
> > >   * that the inode has changed in some fashion.
> > >   *
> > > + * Note that atime updates due to reads or similar activity do _not_ represent
> > > + * an explicit change to the inode. If the only change is to the atime and it
> > 
> > Thanks, Jeff.  The ext4 patch increments i_version on file metadata
> > changes.  Could the wording here be more explicit to reflect changes
> > based on either inode data or metadata changes?b
> > 
> > 
> 
> Thanks Mimi,
> 
> Care to suggest some wording?
> 
> The main issue we have is that ext4 and xfs both increment i_version on
> atime updates due to reads. I have patches in flight to fix those, but
> going forward, we want to ensure that i_version gets incremented on all
> changes _except_ for atime updates.
> 
> The best wording we have at the moment is what Trond suggested, which is
> to classify the changes to the inode as "explicit" (someone or something
> made a deliberate change to the inode) and "implicit" (the change to the
> inode was due to activity such as reads that don't actually change
> anything).
> 
> Is there a better way to describe this?

"explicit change to the inode" probably implies both the inode file
data and metadata, but let's call it out by saying "an explicit change
to either the inode data or metadata".

> 
> > > + * wasn't set via utimes() or a similar mechanism, then i_version should not be
> > > + * incremented. If an observer cares about atime updates, it should plan to
> > > + * fetch and store them in conjunction with the i_version.
> > > + *
> > >   * Not all filesystems properly implement the i_version counter. Subsystems that
> > >   * want to use i_version field on an inode should first check whether the
> > >   * filesystem sets the SB_I_VERSION flag (usually via the IS_I_VERSION macro).
> > 
> > 
> 


