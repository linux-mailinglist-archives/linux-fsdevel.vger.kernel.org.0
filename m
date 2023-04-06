Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7705C6DA29B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 22:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239344AbjDFUXQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 16:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239303AbjDFUW6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:22:58 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80FD83D0;
        Thu,  6 Apr 2023 13:22:52 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336KI56s008463;
        Thu, 6 Apr 2023 20:22:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=/MsDfhcwv1aeSPrjlvxkm2qnG73ivE0rBCDMjk4/Vw0=;
 b=j4NQSYsJSDxAm7KiDnGYWBm5huGCcz+7HTFWHbOTaTHzYJEAgK7d2qa34L+qGpun+NuO
 sJL4G7SzWwzlvfm1pL9Kf5MCpxWQP18bkFpJGccK1VvsfZlnAyMPpAilGI3Mz2HF34nq
 dHUJdyjQA8mDb6+o0DILTW3fGEZpaFV7R3J24xnjauWNb6rT2jzNLZ0zaWk86fq03Rfj
 BqhnWGCpulSwWaxLWjuoTbSpqMUy069bPbfXE+QJ25zyR8pgslBGThc83Qw2/zq0LV/s
 tHwCxSlG+xzrqxxE8RWeAZXXHO4k+IFlQs7MpPeKi5dffrmaSVzi1B8xHM9JVaXwPyWl Fw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pt0n86s8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 20:22:47 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 336KG9aN001324;
        Thu, 6 Apr 2023 20:22:46 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pt0n86s8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 20:22:46 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 336IJAe9008642;
        Thu, 6 Apr 2023 20:22:45 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3ppc884f98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 20:22:45 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 336KMi8H35390164
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Apr 2023 20:22:44 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81BB058065;
        Thu,  6 Apr 2023 20:22:44 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D73015805D;
        Thu,  6 Apr 2023 20:22:43 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  6 Apr 2023 20:22:43 +0000 (GMT)
Message-ID: <d61ed13b-0fd2-0283-96d2-0ff9c5e0a2f9@linux.ibm.com>
Date:   Thu, 6 Apr 2023 16:22:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] overlayfs: Trigger file re-evaluation by IMA / EVM after
 writes
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Paul Moore <paul@paul-moore.com>
Cc:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        miklos@szeredi.hu, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        amir73il@gmail.com
References: <20230405171449.4064321-1-stefanb@linux.ibm.com>
 <20230406-diffamieren-langhaarig-87511897e77d@brauner>
 <CAHC9VhQsnkLzT7eTwVr-3SvUs+mcEircwztfaRtA+4ZaAh+zow@mail.gmail.com>
 <a6c6e0e4-047f-444b-3343-28b71ddae7ae@linux.ibm.com>
 <CAHC9VhQyWa1OnsOvoOzD37EmDnESfo4Rxt2eCSUgu+9U8po-CA@mail.gmail.com>
 <20230406-wasser-zwanzig-791bc0bf416c@brauner>
 <546145ecbf514c4c1a997abade5f74e65e5b1726.camel@kernel.org>
 <45a9c575-0b7e-f66a-4765-884865d14b72@linux.ibm.com>
 <60339e3bd08a18358ac8c8a16dc67c74eb8ba756.camel@kernel.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <60339e3bd08a18358ac8c8a16dc67c74eb8ba756.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0kxBs7aOoMX05U5Ez91ZlVHQBb9RoNTL
X-Proofpoint-ORIG-GUID: BkvmzbtbUhACM0b9WhFBFd5zwkdiDrLT
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_12,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304060173
X-Spam-Status: No, score=-2.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4/6/23 15:37, Jeff Layton wrote:
> On Thu, 2023-04-06 at 15:11 -0400, Stefan Berger wrote:
>>
>> On 4/6/23 14:46, Jeff Layton wrote:
>>> On Thu, 2023-04-06 at 17:01 +0200, Christian Brauner wrote:
>>>> On Thu, Apr 06, 2023 at 10:36:41AM -0400, Paul Moore wrote:
>>
>>>
>>> Correct. As long as IMA is also measuring the upper inode then it seems
>>> like you shouldn't need to do anything special here.
>>
>> Unfortunately IMA does not notice the changes. With the patch provided in the other email IMA works as expected.
>>
> 
> 
> It looks like remeasurement is usually done in ima_check_last_writer.
> That gets called from __fput which is called when we're releasing the
> last reference to the struct file.
> 
> You've hooked into the ->release op, which gets called whenever
> filp_close is called, which happens when we're disassociating the file
> from the file descriptor table.
> 
> So...I don't get it. Is ima_file_free not getting called on your file
> for some reason when you go to close it? It seems like that should be
> handling this.

I would ditch the original proposal in favor of this 2-line patch shown here:

https://lore.kernel.org/linux-integrity/a95f62ed-8b8a-38e5-e468-ecbde3b221af@linux.ibm.com/T/#m3bd047c6e5c8200df1d273c0ad551c645dd43232


The new proposed i_version increase occurs on the inode that IMA sees later on for
the file that's being executed and on which it must do a re-evaluation.

Upon file changes ima_inode_free() seems to see two ima_file_free() calls,
one for what seems to be the upper layer (used for vfs_* functions below)
and once for the lower one.
The important thing is that IMA will see the lower one when the file gets
executed later on and this is the one that I instrumented now to have its
i_version increased, which in turn triggers the re-evaluation of the file post
modification.

static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
[...]
	struct fd real;
[...]
	ret = ovl_real_fdget(file, &real);
	if (ret)
		goto out_unlock;

[...]
	if (is_sync_kiocb(iocb)) {
		file_start_write(real.file);
-->		ret = vfs_iter_write(real.file, iter, &iocb->ki_pos,
				     ovl_iocb_to_rwf(ifl));
		file_end_write(real.file);
		/* Update size */
		ovl_copyattr(inode);
	} else {
		struct ovl_aio_req *aio_req;

		ret = -ENOMEM;
		aio_req = kmem_cache_zalloc(ovl_aio_request_cachep, GFP_KERNEL);
		if (!aio_req)
			goto out;

		file_start_write(real.file);
		/* Pacify lockdep, same trick as done in aio_write() */
		__sb_writers_release(file_inode(real.file)->i_sb,
				     SB_FREEZE_WRITE);
		aio_req->fd = real;
		real.flags = 0;
		aio_req->orig_iocb = iocb;
		kiocb_clone(&aio_req->iocb, iocb, real.file);
		aio_req->iocb.ki_flags = ifl;
		aio_req->iocb.ki_complete = ovl_aio_rw_complete;
		refcount_set(&aio_req->ref, 2);
-->		ret = vfs_iocb_iter_write(real.file, &aio_req->iocb, iter);
		ovl_aio_put(aio_req);
		if (ret != -EIOCBQUEUED)
			ovl_aio_cleanup_handler(aio_req);
	}
         if (ret > 0)						<--- this get it to work
                 inode_maybe_inc_iversion(inode, false);		<--- since this inode is known to IMA
out:
         revert_creds(old_cred);
out_fdput:
         fdput(real);

out_unlock:
         inode_unlock(inode);




    Stefan

> 
> In any case, I think this could use a bit more root-cause analysis.

