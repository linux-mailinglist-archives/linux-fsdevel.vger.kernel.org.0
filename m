Return-Path: <linux-fsdevel+bounces-77254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oK7fL/cSkmkYqQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Feb 2026 19:39:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 587D013F6F8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Feb 2026 19:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0937A3003D1C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Feb 2026 18:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F36C2F25F0;
	Sun, 15 Feb 2026 18:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="do+hSaj5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4676318BC3D;
	Sun, 15 Feb 2026 18:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771180787; cv=none; b=EASej8KvitiAjYBC3E8HOgprkzsZk+PQ9v49E4pfYZe0WvYF+EH29g0zc3pdnCXSQuY2TT3rLPA+i4+KYO2Cl5jeniOAlqaNwgvcoPlRG949dtGj2uwM+oXk2P9r7l3AjNVd0R9ltL3vC3Ci3IoUaPZirwp/8K9TCWuV2+G5Va0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771180787; c=relaxed/simple;
	bh=3UQPuHpwVGZedK837cAJGJcfIeUpGWZh9UeWpkGLcUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uo1i0trGD5k0VFLYjw2s9DhFQen5ESa0T8/C/j1bIj155/czgR91qzRQYMw4xQuimm92dK04XcqLhwIpfr+HxGUxCVanm8kehG6HMenYqwZs/1ceeBKmQHgVCmEkf0doNvrfFyWKQ7RNhY2qP4gmMbtzjpbdZtiyNU5fCHsvA3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=do+hSaj5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61F7qL4e2084692;
	Sun, 15 Feb 2026 18:39:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=z3IZXT
	ytivLgsLaRggR5ZSvj+TzkGEdfTe8dQfvKv5s=; b=do+hSaj5mwRoGttvxj9Hl1
	g73SmI0xYRjx5SkFClA66fsw4Mm9vSxe+XSdpyD3f/rVFSZpIg5L6w6BX+ZQRed9
	N8bpVOUMhtMfs96wCjBOet4ZG7VGsNhHlbFHO+VUhA6PhIU/RpgF2aCL2kO26Ev3
	GsgP/y+X9CQgjVnvWHfj+U8vXn8WQSRpM6NEw4Q7bPMSamcXcufs/IpT0shnaxBg
	fDlV6bs/hcomrM3S8MgV5jYkq5sdnKt7cUI57emliWkzlRskP9oouVI3UZavk88l
	DGFgP1fq1wDiMw9T3WkTJZHuo/H7GsM9X9QJ3jpM7AScXVf7IUY4c+wQH5iTfMyA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcj4ekb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Feb 2026 18:39:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61FF6r4n029059;
	Sun, 15 Feb 2026 18:39:00 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cb63129h8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Feb 2026 18:39:00 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61FIcxvT16646782
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Feb 2026 18:39:00 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D181358058;
	Sun, 15 Feb 2026 18:38:59 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA1E958057;
	Sun, 15 Feb 2026 18:38:49 +0000 (GMT)
Received: from [9.87.129.147] (unknown [9.87.129.147])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 15 Feb 2026 18:38:49 +0000 (GMT)
Message-ID: <901f4daf-3226-416f-8741-dd15573e736b@linux.ibm.com>
Date: Mon, 16 Feb 2026 00:08:47 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status,
 expansion plan for the storage stack test framework
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Daniel Wagner <dwagner@suse.de>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
        Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.de>,
        hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "sagi@grimberg.me" <sagi@grimberg.me>, "tytso@mit.edu" <tytso@mit.edu>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christian Brauner <brauner@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
        "willy@infradead.org" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "vbabka@suse.cz"
 <vbabka@suse.cz>,
        Damien Le Moal <dlemoal@kernel.org>
References: <31a2a4c2-8c33-429a-a2b1-e1f3a0e90d72@nvidia.com>
 <459953fa-5330-4eb1-a1b4-7683b04e3d45@flourine.local>
 <aY77ogf5nATlJUg_@shinmob>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aY77ogf5nATlJUg_@shinmob>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: iuM4XSTf3nmzwplSwaI96Fz7Ehw_Njdp
X-Authority-Analysis: v=2.4 cv=Md9hep/f c=1 sm=1 tr=0 ts=699212c6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=9DavVDRZC1PGIyvR4eoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE1MDE1NiBTYWx0ZWRfX9xTEi0WmpuNT
 Nx85veqB+uTT3Po4h/LCWBJkIAnjL25zyEykxRSCvTzJvqfDQrSs6MAecuNs+mk/rxrT0daDvLG
 9Z8eROeXjhwqbjX37V4C16nsi5BTqnt302CPvEvlg+v4+eMYtU2sQs2ZKHRAO1OLaJeCtQuKO+g
 xB1nNYUdmzAgJa/FhfSZJ2MicZeXCPzSBR10Sla0aXviFSR/6++PWqgDb8HLbz3Ot1lKJ7g/hWB
 RrZAN0nQWZhE0foe31VGjguvnP8D5I8dvL+rTN7hJGA2JZNHwhzZA+sDBXSieF7jtIxR71OIbNM
 5RuocyxJ/wIJ/C11ydhpn8W5m8rlRpVlqtnvELI37XV8lVqhV/Cm0+hGJG+WTd+iZqyd2sX7N4J
 avl/dR0641EGgClTe5BsFQRt7i+/Rx9dcY9gdHAT/VMi/DC/UGKn9itPBXs3z2xI6o0aHfKW7HV
 vmXcxfTvuiAduAr4CyA==
X-Proofpoint-GUID: mhOu39Tkuncs14cshF6xz_qZqEAv93qp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-15_06,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602150156
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,vger.kernel.org,lists.infradead.org,lists.linux-foundation.org,acm.org,suse.de,lst.de,kernel.dk,grimberg.me,mit.edu,wdc.com,kernel.org,oracle.com,javigon.com,infradead.org,suse.cz,gmail.com];
	TAGGED_FROM(0.00)[bounces-77254-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nilay@linux.ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 587D013F6F8
X-Rspamd-Action: no action



On 2/13/26 4:53 PM, Shinichiro Kawasaki wrote:
> On Feb 12, 2026 / 08:52, Daniel Wagner wrote:
>> On Wed, Feb 11, 2026 at 08:35:30PM +0000, Chaitanya Kulkarni wrote:
>>>    For the storage track at LSFMMBPF2026, I propose a session dedicated to
>>>    blktests to discuss expansion plan and CI integration progress.
>>
>> Thanks for proposing this topic.
> 
> Chaitanya, my thank also goes to you.
> 
Yes thanks for proposing this!

>> Just a few random topics which come to mind we could discuss:
>>
>> - blktests has gain a bit of traction and some folks run on regular
>>   basis these tests. Can we gather feedback from them, what is working
>>   good, what is not? Are there feature wishes?
> 
> Good topic, I also would like to hear about it.
> 
One improvement I’d like to highlight is related to how blktests are executed
today. So far, we’ve been running blktests serially, but if it's possible to 
run tests in parallel to improve test turnaround time and make large-scale or
CI-based testing more efficient? For instance, adding parallel_safe Tags: Marking tests
that don't modify global kernel state so they can be safely offloaded to parallel
workers. Marking parallel_safe tags would allow the runner to distinguish:

Safe Tests: Tests that only perform I/O on a specific, non-shared device or 
check static kernel parameters.

Unsafe Tests: Tests that reload kernel modules, modify global /sys or /proc entries,
or require exclusive access to specific hardware addresses.

Yes adding parallel execution support shall require framework/design changes. 

> FYI, from the past LSFMM sessions and hallway talks, major feedbacks I had
> received are these two:
> 
>  1. blktests CI infra looks missing (other than CKI by Redhat)
>     -> Some activities are ongoing to start blktests CI service.
>        I hope the status are shared at the session.
> 
>  2. blktests are rather difficult to start using for some new users
>     -> I think config example is demanded, so that new users can
>        just copy it to start the first run, and understand the
>        config options easily.
> 
>> - Do we need some sort of configuration tool which allows to setup a
>>   config? I'd still have a TODO to provide a config example with all
>>   knobs which influence blktests, but I wonder if we should go a step
>>   further here, e.g. something like kdevops has?
> 
> Do you mean the "make menuconfig" style? Most of the blktests users are
> familiar with menuconfig, so that would be an idea. If users really want
> it, we can think of it. IMO, blktests still do not have so many options,
> then config.example would be simpler and more appropriate, probably.
> 
>> - Which area do we lack tests? Should we just add an initial simple
>>   tests for the missing areas, so the basic infra is there and thus
>>   lowering the bar for adding new tests?
> 
> To identify the uncovered area, I think code coverage will be useful. A few
> years ago, I measured it and shared in LSFMM, but that measurement was done for
> each source tree directory. The coverage ratio by source file will be more
> helpful to identify the missing area. I don't have time slot to measure it,
> so if anyone can do it and share the result, it will be appreciated. Once we
> know the missing areas, it sounds a good idea to add initial samples for each
> of the areas.
> 
>> - The recent addition of kmemleak shows it's a great idea to enable more
>>   of the kernel test infrastructure when running the tests.
> 
> Completely agreed.
> 
>>   Are there more such things we could/should enable?
> 
> I'm also interested in this question :)
> 
>> - I would like to hear from Shin'ichiro if he is happy how things
>>   are going? :)
> 
> More importantly, I would like to listen to voices from storage sub-system
> developers to see if they are happy or not, especially the maintainers.
> 
> From my view, blktests keep on finding kernel bugs. I think it demonstrates the
> value of this community effort, and I'm happy about it. Said that, I find what
> blktests can improve more, of course. Here I share the list of improvement
> opportunities from my view point (I already mentioned the first three items).
> 
>  1. We can have more CI infra to make the most of blktests
>  2. We can add config examples to help new users
>  3. We can measure code coverage to identify missing test areas
>  4. Long standing failures make test result reports dirty
>     - I feel lockdep WARNs are tend to be left unfixed rather long period.
>       How can we gather effort to fix them?

I agree regarding lockdep; recently we did see quite a few lockdep splats.
That said, I believe the number has dropped significantly and only a small
set remains. From what I can tell, most of the outstanding lockdep issues
are related to fs-reclaim paths recursing into the block layer while the
queue is frozen. We should be able to resolve most of these soon, or at
least before the conference. If anything is still outstanding after that,
we can discuss it during the conference and work toward addressing it as
quickly as possible.

>  5. We can refactor and clean up blktests framework for ease of maintainance
>       (e.g. trap handling)
>  6. Some users run blktests with built-in kernel modules, which makes a number
>     of test cases skipped. We can add more built-in kernel modules support to
>     expand test coverage for such use case.

Thanks,
--Nilay

