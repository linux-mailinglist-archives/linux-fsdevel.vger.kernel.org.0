Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 598A0B402F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2019 20:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390301AbfIPSSr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Sep 2019 14:18:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51094 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729765AbfIPSSr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Sep 2019 14:18:47 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8GI8jWl020426;
        Mon, 16 Sep 2019 18:18:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=QLq4nnabSQvNaHQNUlM9lQ61GOayOg/Jx/HdebGsyaY=;
 b=a915c6hMEYjvEDztwG3t4nuTGUHb60K7qMVVL5mDxZOaR0aIEapgDwlQJKnQTGfbxgEm
 lmayJsbOhwqiAKUKabvCht1w9CXhlBp4EMPS9YBlZ+NwLO7PzloSotwD1es+SYYogRIf
 LjU+4uQUOn8k3EFVR8XIviJlLupU9Ca/gXIiPuDxtQRKF+8NOBrYpbe9DPltYfZv/HDQ
 nEgxxRKlCZO/8TVp2/hpBDpD5FYO2xIzwkZT1JWyBVZGZaCTWM7Ehs0eTafxokiNk7hS
 1uhmg2CivQOtOIDvDi2EKiYANLuIZd/66tVpskTzQmSKKZENHricVzUmy5esvhhU/UKg 0Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2v0r5p99at-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Sep 2019 18:18:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8GI8dVv075942;
        Mon, 16 Sep 2019 18:16:37 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2v0nb54yga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Sep 2019 18:16:37 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8GIGaRc018641;
        Mon, 16 Sep 2019 18:16:36 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Sep 2019 11:16:35 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: IMA on remote file systems
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20190916161054.GB4553@mit.edu>
Date:   Mon, 16 Sep 2019 14:16:34 -0400
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Michael Halcrow <mhalcrow@google.com>,
        "Theodore Y. Ts'o" <tytso@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Eric Biggers <ebiggers@google.com>
Content-Transfer-Encoding: 7bit
Message-Id: <8E8BBD35-F1DD-49C8-B350-6DDA39E5CC74@oracle.com>
References: <C867A0BA-1ACF-4600-8179-3E15A098846C@oracle.com>
 <FA4C0F15-EE0A-4231-8415-A035C1CF3E32@oracle.com>
 <1568583730.5055.36.camel@linux.ibm.com> <20190916161054.GB4553@mit.edu>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9382 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909160178
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9382 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909160178
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Sep 16, 2019, at 12:10 PM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> 
> On Sun, Sep 15, 2019 at 05:42:10PM -0400, Mimi Zohar wrote:
>>>> My thought was to use an ephemeral Merkle tree for NFS (and
>>>> possibly other remote filesystems, like FUSE, until these
>>>> filesystems support durable per-file Merkle trees). A tree would
>>>> be constructed when the client measures a file, but it would not
>>>> saved to the filesystem. Instead of a hash of the file's contents,
>>>> the tree's root signature is stored as the IMA metadata.
>>>> 
>>>> Once a Merkle tree is available, it can be used in exactly the
>>>> same way that a durable Merkle tree would, to verify the integrity
>>>> of individual pages as they are used, evicted, and then read back
>>>> from the server.
>>>> 
>>>> If the client needs to evict part or all of an ephemeral tree, it
>>>> can subsequently be reconstructed by measuring the file again and
>>>> verifying its root signature against the stored IMA metadata.
> 
> Where would the client store the ephemeral tree?  If you're thinking
> about storing in memory, calculating the emphemeral tree would require
> dragging the entire file across the network, which is going to be just
> as bad as using IMA --- plus the CPU cost of calculating the Merkle
> tree, and the memory cost of storing the ephemeral Merkle tree.

A client would store ephemeral Merkle trees in memory.

The most interesting use case to me is protecting executables and
DLLs. These will tend to be limited in size, so the cost of Merkle
tree construction should be nicely bounded in the typical case.

An additional cost would arise if the in-memory tree were to be
evicted. We hope that is an infrequent event. If the tree is
partially evicted, only some of the file needs to be read back
to re-construct it, since we would still have in-memory hashes
stored in the interior nodes of the tree that enable the client to
verify the portion of the tree that needs to be re-constructed.

The short-term purpose of these trees is to add the value of better
integrity protection for file systems that find it difficult to
store per-file Merkle trees durably. We expect that situation will
be temporary for many file systems, though not all.

The price that is paid for this extra protection is that it will
perform like traditional IMA, as you observed above. This is probably
a different cost than reading from flash on a mobile device: a typical
NFS client will be less memory- and CPU-constrained than a mobile
device, and the cost of reading over NFS on a fast network from the
server's cache is not high. The trade-offs here are going to be
different.


> I suspect that for most clients, it wouldn't be worth it unless the
> client can store the ephemeral tree *somewhere* on the client's local
> persistent storage, or maybe if it could store the Merkle tree on the
> NFS server (maybe via an xattr which contains the pathname to the
> Merkle tree relative to the NFS mount point?).

The trees could be cached locally for exceptionally large files (eg
files larger than the client's physical memory). For smaller files,
which I expect will be the typical case, the cost of reading a file
will be about the same as reading a Merkle tree.

As mentioned in my proposal, the eventual goal is to extend the NFS
protocol to store the Merkle tree durably on the server. We will get
there eventually. Changing the protocol is a slow process, particularly
because it involves consensus among NFS implementers who work on other
operating systems besides Linux.


>>>> So the only difference here is that the latency-to-first-byte
>>>> benefit of a durable Merkle tree would be absent.
> 
> What problem are you most interested in solving?  And what cost do you
> think the user will be willing to pay in order to solve that problem?

NFS users would get full protection of their files from storage
to point-of-use, at the same cost as IMA, until some point in the
future when NFS can store the trees durably. The same would apply
to other filesystems that find storing a full Merkle tree to be
a challenge.


>> I like the idea, but there are a couple of things that need to happen
>> first.  Both fs-verity and IMA appended signatures need to be
>> upstreamed.
> 
> Eric has sent the pull request fs-verity today.
> 
>>  The IMA appended signature support simplifies
>> ima_appraise_measurement(), paving the way for adding IMA support for
>> other types of signature verification.  How IMA will support fs-verity 
>> signatures still needs to be defined.  That discussion will hopefully
>> include NFS support.
> 
> As far as using the Merkle tree root hash for the IMA measurement,
> what sort of policy should be used for determining when the Merkle
> tree root hash should be used in preference to reading and checksuming
> the whole file when it is first opened?  It could be as simple as, "if
> this is a fs-verity, use the fs-verity Merkle root".  Is that OK?
> 
>     	  	     	     	       	      - Ted

--
Chuck Lever



