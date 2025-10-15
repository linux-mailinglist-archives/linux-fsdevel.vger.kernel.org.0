Return-Path: <linux-fsdevel+bounces-64245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 19786BDF567
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 17:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 816B44EC00F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 15:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A82F2FE079;
	Wed, 15 Oct 2025 15:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eaRV0UHu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497A526CE06;
	Wed, 15 Oct 2025 15:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760542012; cv=none; b=qEILPb92sqxt8djLLENnsIBfUSlwXB2vxO0ccKgIYf0GC1naUmsXPITioRX4L8j1kVFoO1d8aTy0I58ixzH3it801KOlVMhrk5jPXCunhj2E/MLgPK3mGbY6C4OB0d1mTFlzSeTvThYaxYRJ2dXRO69H+UGQXQvXaRDCieIklXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760542012; c=relaxed/simple;
	bh=VpJ11xGa+BDz4uhi6bmHjmcicPo7D85MQp8q2vvOikk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YWMbf7Gj4JCrPOilXOh3bgDa4r81bfWVddGqtNrn5gw3qyRlb1HjFCai/kOHDt8FjABu7WD2jK5hDN/rMXwY1GOM8ce6+qwcKUMby5IAC4uBbcUcEukJyy28O2idDJknafQ1h7ZV6JB54ovCYwBNjBKQDCO8iUGCuWdaY28DUAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eaRV0UHu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CE9C4CEF8;
	Wed, 15 Oct 2025 15:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760542011;
	bh=VpJ11xGa+BDz4uhi6bmHjmcicPo7D85MQp8q2vvOikk=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=eaRV0UHuNmiyqyQaSHmpM3Av7AfV06g40dGfsZzhcTIUqMDXB0LmH8GxDCv9SESXo
	 TFSve6l9Dyu4S9Zoq2yjlbLkhtOARzi9zind3tFCIlOJ6RoTlFiVwdSrkcIPz6SD6Q
	 SssbkXJjwzztIVxF4CqW0HNUPCQav0PHh5qxJf/k5lH2kzuCuhQmNwNJKIfuz/o9qc
	 UySTwrGVXib/3txrj0/Bj3ajpUJaWdkmz/khvoOd2wJCy/nHP1MG8FOmuJLWnJ/gje
	 3rC7Jtnfw8spmjh1SEYa51KwDaA9Ncxr5W15neqLVtBIl3GLO8Bki+B5Dk2eqcR36a
	 pDd++gI92txzA==
Message-ID: <b3c5037b-07c9-4419-b3a4-7cbc16cf43ed@kernel.org>
Date: Wed, 15 Oct 2025 11:25:35 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Chuck Lever <cel@kernel.org>
Subject: Re: [PATCH v5] NFSD: Add a subsystem policy document
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
 Luis Chamberlain <mcgrof@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20251014150958.5372-1-cel@kernel.org>
 <20251014235803.GH6215@frogsfrogsfrogs>
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <20251014235803.GH6215@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/14/25 7:58 PM, Darrick J. Wong wrote:
> On Tue, Oct 14, 2025 at 11:09:58AM -0400, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> Steer contributors to NFSD's patchworks instance, list our patch
>> submission preferences, and more. The new document is based on the
>> existing netdev and xfs subsystem policy documents.
>>
>> This is an attempt to add transparency to the process of accepting
>> contributions to NFSD and getting them merged upstream.
>>
>> Suggested-by: Darrick J. Wong <djwong@kernel.org>
> 
> Dumb nit:  The period after the J means you have to enclose the whole
> mess in quotations to be rfc822 compliant:
> 
> Suggested-by: "Darrick J. Wong" <djwong@kernel.org>
> 
> (and no, nobody gets this right, not even me for a large number of
> years)
> 
>> Cc: Luis Chamberlain <mcgrof@kernel.org>
>> Cc: Martin K. Petersen <martin.petersen@oracle.com>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  .../nfs/nfsd-maintainer-entry-profile.rst     | 545 ++++++++++++++++++
>>  .../maintainer/maintainer-entry-profile.rst   |   1 +
>>  MAINTAINERS                                   |   1 +
>>  3 files changed, 547 insertions(+)
>>  create mode 100644 Documentation/filesystems/nfs/nfsd-maintainer-entry-profile.rst
>>
>> I'd like to apply this for v6.19. Can I get some R-b love? I promise
>> not to change the document again until it is merged and we have
>> actual version control.
> 
> Assuming you meant from the nfsd community, not really so much from me?

Anyone is welcome to give an R-b. Thanks for your review! I have one
or two responses below.


>> +Reporting bugs
>> +--------------
>> +If you experience an NFSD-related bug on a distribution-built
>> +kernel, please start by working with your Linux distributor.
>> +
>> +Bug reports against upstream Linux code bases are welcome on the
>> +linux-nfs@vger.kernel.org mailing list, where some active triage
>> +can be done. NFSD bugs may also be reported in the Linux kernel
>> +community's bugzilla at:
>> +
>> +  https://bugzilla.kernel.org
>> +
>> +Please file NFSD-related bugs under the "Filesystems/NFSD"
>> +component. In general, including as much detail as possible is a
>> +good start, including pertinent system log messages from both
>> +the client and server.
>> +
>> +For user space software related to NFSD, such as mountd or the
>> +exportfs command, report problems on linux-nfs@vger.kernel.org.
>> +You might be asked to move the report to a specific bug tracker.
> 
> I'm assuming that doesn't include ganesha?

NFS/Ganesha is a completely separate NFS server implementation.
What I'm referring to here is the user space components that NFSD
relies on, as packaged in nfs-utils. I'll update this paragraph
to be more specific.


>> +Testing
>> +~~~~~~~
>> +The kdevops project
>> +
>> +  https://github.com/linux-kdevops/kdevops
>> +
>> +contains several NFS-specific workflows, as well as the community
>> +standard fstests suite. These workflows are based on open source
>> +testing tools such as ltp and fio. Contributors are encouraged to
>> +use these tools without kdevops, or contributors should install and
>> +use kdevops themselves to verify their patches before submission.
> 
> I'm curious, does that include recipes for running fstests over nfs?

Absolutely.

There are five kdevops workflows I currently run for NFSD on upstream
and LTS kernels:

- fstests with scratch device
- the git regression suite
- ltp (ti-rpc and notify, at least)
- Jorge Mora's nfstest suite
- pynfs

These can all be run with xfs, ext4, btrfs, or tmpfs underlying the
NFS exports. But right now I pick a single local filesystem type for
each kernel release to keep the test matrix manageable.


>> +The code in the body of the diff already shows /what/ is being
>> +changed. Thus it is not necessary to repeat that in the patch
>> +description. Instead, the description should contain one or more
>> +of:
>> +
>> +- A brief problem statement ("what is this patch trying to fix?")
>> +  with a root-cause analysis.
>> +
>> +- End-user visible symptoms or items that a support engineer might
>> +  use to search for the patch, like stack traces.
>> +
>> +- A brief explanation of why the patch is the best way to address
>> +  the problem.
>> +
>> +- Any context that reviewers might need to understand the changes
>> +  made by the patch.
>> +
>> +- Any relevant benchmarking results, and/or functional test results.
>> +
>> +As detailed in Documentation/process/submitting-patches.rst,
>> +identify the point in history that the issue being addressed was
>> +introduced by using a Fixes: tag.
> 
> That doesn't apply to new features, right?  Or are those "fixes" for
> missing functionality?

Sometimes a new feature is needed to address a bug. So, I think a
Fixes: tag is sometimes appropriate even for patches that introduce
features.


> Are Anna or Trond working on a similar profile for fs/nfs/?

Not that I'm aware of.


> Does this profile document cover fs/nfs_common/ ?

It could, if that's listed under the NFSD paragraph in MAINTAINERS.


>> +This means that contributors might be asked to resubmit patches if
>> +they were emailed to the incorrect set of maintainers and reviewers.
>> +This is not a rejection, but simply a correction of the submission
>> +process.
>> +
>> +When in doubt, consult the NFSD entry in the MAINTAINERS file to
>> +see which files and directories fall under the NFSD subsystem.
>> +
>> +The proper set of email addresses for NFSD patches are:
>> +
>> +To: the NFSD maintainers and reviewers listed in MAINTAINERS
>> +Cc: linux-nfs@vger.kernel.org and optionally linux-kernel@
>> +
>> +If there are other subsystems involved in the patches (for example
>> +MM or RDMA) their primary mailing list address can be included in
>> +the Cc: field. Other contributors and interested parties may be
>> +included there as well.
>> +
>> +In general we prefer that contributors use common patch email tools
>> +such as "git send-email" or "stg email format/send", which tend to
>> +get the details right without a lot of fuss.
>> +
>> +A series consisting of a single patch is not required to have a
>> +cover letter. However, a cover letter can be included if there is
>> +substantial context that is not appropriate to include in the
>> +patch description.
>> +
>> +Please note that cover letters are not part of the work that is
>> +committed to the kernel source code base or its commit history.
>> +Therefore always try to keep pertinent information in the patch
>> +descriptions.
> 
> Are you willing to take pull requests from people with large patchsets?

Generally we prefer patches to go through the mailing list, as Linus
(and others) will look for author/commit dates and such to match
against email post dates, and because R-b and other tags are pulled in
automatically.

Also, if there's a bug to be reported, posters like to Reply-To the
email patch submission, which would be missing for a pull request
style ingestion.

I'm sure that at some point in the future I will lunch on all of these
words.


> If people sending PRs paste their cover letter into the tag, then you
> effectively preserve that cover letter when you pull the branch.
> Example:
> 
> First I started with:
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/tag/?h=kconfig-2025-changes_2025-09-15
> 
> Then sent a PR to Carlos:
> https://lore.kernel.org/linux-xfs/175708766783.3403120.8622863816662379875.stg-ugh@frogsfrogsfrogs/
> 
> He merged it into his xfs for-next branch, which in turn is what Linus
> pulled:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/xfs?id=e90dcba0a350836a5e1a1ac0f65f9e74644d7d3b
> 
> [and no, it's not going splendidly :(]

I noticed Linus' recent suggestion about ingesting cover letters as
merge commit messages. I might use this mechanism to construct nfsd-next
in the future.

But generally I'm not crazy about adding even more complexity to the
kernel's merge graph this way.


>> +Patches that survive in nfsd-next are included in the next NFSD
>> +merge window pull request. These windows occur once every eight
>> +weeks.
> 
> I thought we were at every 63 days (i.e. 9 weeks)?

Ja. Oops. I will fix this.


>> +Community roles and their authority
>> +-----------------------------------
>> +The purpose of Linux subsystem communities is to provide expertise
>> +and active stewardship of a narrow set of source files in the Linux
>> +kernel. This can include managing user space tooling as well.
>> +
>> +To contextualize the structure of the Linux NFS community that
>> +is responsible for stewardship of the NFS server code base, we
>> +define the community roles here.
>> +
>> +- **Contributor** : Anyone who submits a code change, bug fix,
>> +  recommendation, documentation fix, and so on. A contributor can
>> +  submit regularly or infrequently.
>> +
>> +- **Outside Contributor** : A contributor who is not a regular actor
>> +  in the Linux NFS community. This can mean someone who contributes
>> +  to other parts of the kernel, or someone who just noticed a
>> +  misspelling in a comment and sent a patch.
>> +
>> +- **Reviewer** : Someone who is named in the MAINTAINERS file as a
>> +  reviewer is an area expert who can request changes to contributed
>> +  code, and expects that contributors will address the request.
>> +
>> +- **External Reviewer** : Someone who is not named in the
>> +  MAINTAINERS file as a reviewer, but who is an area expert.
>> +  Examples include Linux kernel contributors with networking,
>> +  security, or persistent storage expertise, or developers who
>> +  contribute primarily to other NFS implementations.
>> +
>> +One or more people will take on the following roles. These people
>> +are often generically referred to as "maintainers", and are
>> +identified in the MAINTAINERS file with the "M:" tag under the NFSD
>> +subsystem.
>> +
>> +- **Upstream Release Manager** : This role is responsible for
>> +  curating contributions into a branch, reviewing test results, and
>> +  then sending a pull request during merge windows. There is a
>> +  trust relationship between the release manager and Linus.
>> +
>> +- **Bug Triager** : Someone who is a first responder to bug reports
>> +  submitted to the linux-nfs mailing list or bug trackers, and helps
>> +  troubleshoot and identify next steps.
>> +
>> +- **Security Lead** : The security lead handles contacts from the
>> +  security community to resolve immediate issues, as well as dealing
>> +  with long-term security issues such as supply chain concerns. For
>> +  upstream, that's usually whether contributions violate licensing
>> +  or other intellectual property agreements.
>> +
>> +- **Testing Lead** : The testing lead builds and runs the test
>> +  infrastructure for the subsystem. The testing lead may ask for
>> +  patches to be dropped because of ongoing high defect rates.
>> +
>> +- **LTS Maintainer** : The LTS maintainer is responsible for managing
>> +  the Fixes: and Cc: stable annotations on patches, and seeing that
>> +  patches that cannot be automatically applied to LTS kernels get
>> +  proper manual backports as necessary.
>> +
>> +- **Community Manager** : This umpire role can be asked to call balls
>> +  and strikes during conflicts, but is also responsible for ensuring
>> +  the health of the relationships within the community and for
>> +  facilitating discussions on long-term topics such as how to manage
>> +  growing technical debt.
> 
> Seems reasonable to me; I hope there's enough people in your community
> to fill out these roles.

Not likely ;-) But it's great to have the housekeeping documented
somewhere. Thanks for getting this started.


-- 
Chuck Lever

