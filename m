Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5A5B324C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2019 23:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfIOVmS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Sep 2019 17:42:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39434 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726139AbfIOVmS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Sep 2019 17:42:18 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8FLfsO3027159
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Sep 2019 17:42:16 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v1dk51bfr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Sep 2019 17:42:16 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 15 Sep 2019 22:42:14 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 15 Sep 2019 22:42:12 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8FLgBG538666264
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 15 Sep 2019 21:42:11 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B33B5204E;
        Sun, 15 Sep 2019 21:42:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.212.53])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9FA285204F;
        Sun, 15 Sep 2019 21:42:10 +0000 (GMT)
Subject: Re: IMA on remote file systems
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Chuck Lever <chuck.lever@oracle.com>,
        linux-integrity@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     Michael Halcrow <mhalcrow@google.com>,
        "Theodore Y. Ts'o" <tytso@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Eric Biggers <ebiggers@google.com>
Date:   Sun, 15 Sep 2019 17:42:10 -0400
In-Reply-To: <FA4C0F15-EE0A-4231-8415-A035C1CF3E32@oracle.com>
References: <C867A0BA-1ACF-4600-8179-3E15A098846C@oracle.com>
         <FA4C0F15-EE0A-4231-8415-A035C1CF3E32@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19091521-0016-0000-0000-000002AC29C1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091521-0017-0000-0000-0000330CC502
Message-Id: <1568583730.5055.36.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-15_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909150236
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2019-09-13 at 10:50 -0400, Chuck Lever wrote:
> Resending ...
> 
> > On Aug 28, 2019, at 1:36 PM, Chuck Lever <chuck.lever@oracle.com> wrote:
> > 
> > Last week I presented at the Linux Security Summit on a proposal
> > for handling IMA metadata on NFS files. My proposal enables storage
> > of per-file IMA metadata via the NFSv4 protocol. I have a prototype
> > and an IETF nfsv4 Working Group document that specifies a small
> > protocol extension.
> > 
> > After the presentation, Mimi Zohar pointed out that although the
> > proposal extends protection from an NFS file server to time-of-
> > measurement on an NFS client, there is still a protection gap between
> > time-of-measurement and time-of-use on that client.
> > 
> > I would like to find a way to extend IMA protection all the way
> > to time-of-use on NFS clients. The consensus is that a per-file
> > Merkle tree would be the most desirable approach, as that is the
> > same mechanism used for fs-verity protection.
> > 
> > For a few important reasons, it will be challenging to plumb
> > support for durable Merkle trees into NFS, although that is an
> > eventual goal.
> > 
> > My thought was to use an ephemeral Merkle tree for NFS (and
> > possibly other remote filesystems, like FUSE, until these
> > filesystems support durable per-file Merkle trees). A tree would
> > be constructed when the client measures a file, but it would not
> > saved to the filesystem. Instead of a hash of the file's contents,
> > the tree's root signature is stored as the IMA metadata.
> > 
> > Once a Merkle tree is available, it can be used in exactly the
> > same way that a durable Merkle tree would, to verify the integrity
> > of individual pages as they are used, evicted, and then read back
> > from the server.
> > 
> > If the client needs to evict part or all of an ephemeral tree, it
> > can subsequently be reconstructed by measuring the file again and
> > verifying its root signature against the stored IMA metadata.
> > 
> > So the only difference here is that the latency-to-first-byte
> > benefit of a durable Merkle tree would be absent.
> > 
> > I'm interested in any thoughts or opinions about this approach.

I like the idea, but there are a couple of things that need to happen
first.  Both fs-verity and IMA appended signatures need to be
upstreamed.  The IMA appended signature support simplifies
ima_appraise_measurement(), paving the way for adding IMA support for
other types of signature verification.  How IMA will support fs-verity 
signatures still needs to be defined.  That discussion will hopefully
include NFS support.

Mimi

