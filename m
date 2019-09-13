Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79C4EB229E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2019 16:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389735AbfIMOuu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Sep 2019 10:50:50 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47910 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388958AbfIMOut (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Sep 2019 10:50:49 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8DEnTs0037790;
        Fri, 13 Sep 2019 14:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=z7Oj/2+QnXnuNDz0btdjyuILiX41y6Jg0NiNcODfJSo=;
 b=H9ei/TPHG6hHwTCVyNanBV1iBy8XWSs27RVeazmdKWkO8g99i3lyqe1OpdJCROGte61d
 LqPQgnaqnJ4OCiEhsCMUhh5/hvD1cs+bxX1rrLf/U+gci2DyMClgckzF/1aJpmfn22/a
 n6NAv4xn+hZnzVC6a3+NM1iIQTur28NGZhpx1U7wFujUvNBdVOi5jr5e3yniGsocN6hp
 rJJWK5j9B2Uxmo/6VEqZk3h6/YLgC/PZV/mEOCW4GS7z8hG609ZcLTvJcpJsZmBiWrnt
 7Ff4w0z6hok/2N0wEQoyvEvcjBixVhB7bAapUpwnVFoKkwTIi67kQF+CYZpNejm3/gxX fg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2uytd3n70w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Sep 2019 14:50:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8DEmLO5085833;
        Fri, 13 Sep 2019 14:50:43 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2v0cwjgx6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Sep 2019 14:50:43 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8DEogRN016346;
        Fri, 13 Sep 2019 14:50:42 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Sep 2019 07:50:42 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: IMA on remote file systems
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <C867A0BA-1ACF-4600-8179-3E15A098846C@oracle.com>
Date:   Fri, 13 Sep 2019 10:50:41 -0400
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Michael Halcrow <mhalcrow@google.com>,
        "Theodore Y. Ts'o" <tytso@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Eric Biggers <ebiggers@google.com>
Content-Transfer-Encoding: 7bit
Message-Id: <FA4C0F15-EE0A-4231-8415-A035C1CF3E32@oracle.com>
References: <C867A0BA-1ACF-4600-8179-3E15A098846C@oracle.com>
To:     linux-integrity@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9379 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909130148
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9379 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909130149
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Resending ...

> On Aug 28, 2019, at 1:36 PM, Chuck Lever <chuck.lever@oracle.com> wrote:
> 
> Last week I presented at the Linux Security Summit on a proposal
> for handling IMA metadata on NFS files. My proposal enables storage
> of per-file IMA metadata via the NFSv4 protocol. I have a prototype
> and an IETF nfsv4 Working Group document that specifies a small
> protocol extension.
> 
> After the presentation, Mimi Zohar pointed out that although the
> proposal extends protection from an NFS file server to time-of-
> measurement on an NFS client, there is still a protection gap between
> time-of-measurement and time-of-use on that client.
> 
> I would like to find a way to extend IMA protection all the way
> to time-of-use on NFS clients. The consensus is that a per-file
> Merkle tree would be the most desirable approach, as that is the
> same mechanism used for fs-verity protection.
> 
> For a few important reasons, it will be challenging to plumb
> support for durable Merkle trees into NFS, although that is an
> eventual goal.
> 
> My thought was to use an ephemeral Merkle tree for NFS (and
> possibly other remote filesystems, like FUSE, until these
> filesystems support durable per-file Merkle trees). A tree would
> be constructed when the client measures a file, but it would not
> saved to the filesystem. Instead of a hash of the file's contents,
> the tree's root signature is stored as the IMA metadata.
> 
> Once a Merkle tree is available, it can be used in exactly the
> same way that a durable Merkle tree would, to verify the integrity
> of individual pages as they are used, evicted, and then read back
> from the server.
> 
> If the client needs to evict part or all of an ephemeral tree, it
> can subsequently be reconstructed by measuring the file again and
> verifying its root signature against the stored IMA metadata.
> 
> So the only difference here is that the latency-to-first-byte
> benefit of a durable Merkle tree would be absent.
> 
> I'm interested in any thoughts or opinions about this approach.

--
Chuck Lever



