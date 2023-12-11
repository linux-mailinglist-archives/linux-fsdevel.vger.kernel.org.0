Return-Path: <linux-fsdevel+bounces-5567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C661C80DADE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 20:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 310EC282017
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 19:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E7452F8E;
	Mon, 11 Dec 2023 19:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SpUL3WxR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6DE9F;
	Mon, 11 Dec 2023 11:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702322858; x=1733858858;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H67yLPzbUzKkxNmLTlc0D2fbLm38haawLELTNmdVRqA=;
  b=SpUL3WxRtRmpYc82iBHpLqyIX4PhggRgjtTVI0BWtAYKgRxCTrCplsbT
   zy8jZLzA1d3hXxyM6HkVBvlmgvjWZ3PUvkuESbe+zqDIh8bPIa6TQUmbQ
   vknko3Z/Dx+dF9w/dTjGf0zhoMIPspa3zMQKzHRt+kowkvo8aGlFNhO3F
   w=;
X-IronPort-AV: E=Sophos;i="6.04,268,1695686400"; 
   d="scan'208";a="367832945"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-5eae960a.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 19:27:36 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2c-m6i4x-5eae960a.us-west-2.amazon.com (Postfix) with ESMTPS id 56C0B40D4B;
	Mon, 11 Dec 2023 19:27:34 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:31063]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.235:2525] with esmtp (Farcaster)
 id 6d89d48b-7d1b-4732-8426-8adeb261d061; Mon, 11 Dec 2023 19:27:33 +0000 (UTC)
X-Farcaster-Flow-ID: 6d89d48b-7d1b-4732-8426-8adeb261d061
Received: from EX19D010UWA004.ant.amazon.com (10.13.138.204) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Dec 2023 19:27:33 +0000
Received: from dev-dsk-kamatam-2b-b66a5860.us-west-2.amazon.com (10.169.6.191)
 by EX19D010UWA004.ant.amazon.com (10.13.138.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Dec 2023 19:27:33 +0000
From: Munehisa Kamata <kamatam@amazon.com>
To: <serge@hallyn.com>
CC: <adobriyan@gmail.com>, <akpm@linux-foundation.org>,
	<casey@schaufler-ca.com>, <kamatam@amazon.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<paul@paul-moore.com>
Subject: Re: Fw: [PATCH] proc: Update inode upon changing task security attribute
Date: Mon, 11 Dec 2023 19:27:23 +0000
Message-ID: <20231211192723.28230-1-kamatam@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231210144530.GB295678@mail.hallyn.com>
References: <20231210144530.GB295678@mail.hallyn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D040UWA002.ant.amazon.com (10.13.139.113) To
 EX19D010UWA004.ant.amazon.com (10.13.138.204)

On Sun, 2023-12-10 06:45:30 -0800, "Serge E. Hallyn" wrote:
>
> On Sat, Dec 09, 2023 at 01:10:42AM +0000, Munehisa Kamata wrote:
> > On Sat, 2023-12-09 00:24:42 +0000, Casey Schaufler wrote:
> > >
> > > On 12/8/2023 3:32 PM, Paul Moore wrote:
> > > > On Fri, Dec 8, 2023 at 6:21 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > > >> On 12/8/2023 2:43 PM, Paul Moore wrote:
> > > >>> On Thu, Dec 7, 2023 at 9:14 PM Munehisa Kamata <kamatam@amazon.com> wrote:
> > > >>>> On Tue, 2023-12-05 14:21:51 -0800, Paul Moore wrote:
> > > >>> ..
> > > >>>
> > > >>>>> I think my thoughts are neatly summarized by Andrew's "yuk!" comment
> > > >>>>> at the top.  However, before we go too much further on this, can we
> > > >>>>> get clarification that Casey was able to reproduce this on a stock
> > > >>>>> upstream kernel?  Last I read in the other thread Casey wasn't seeing
> > > >>>>> this problem on Linux v6.5.
> > > >>>>>
> > > >>>>> However, for the moment I'm going to assume this is a real problem, is
> > > >>>>> there some reason why the existing pid_revalidate() code is not being
> > > >>>>> called in the bind mount case?  From what I can see in the original
> > > >>>>> problem report, the path walk seems to work okay when the file is
> > > >>>>> accessed directly from /proc, but fails when done on the bind mount.
> > > >>>>> Is there some problem with revalidating dentrys on bind mounts?
> > > >>>> Hi Paul,
> > > >>>>
> > > >>>> https://lkml.kernel.org/linux-fsdevel/20090608201745.GO8633@ZenIV.linux.org.uk/
> > > >>>>
> > > >>>> After reading this thread, I have doubt about solving this in VFS.
> > > >>>> Honestly, however, I'm not sure if it's entirely relevant today.
> > > >>> Have you tried simply mounting proc a second time instead of using a bind mount?
> > > >>>
> > > >>>  % mount -t proc non /new/location/for/proc
> > > >>>
> > > >>> I ask because from your description it appears that proc does the
> > > >>> right thing with respect to revalidation, it only becomes an issue
> > > >>> when accessing proc through a bind mount.  Or did I misunderstand the
> > > >>> problem?
> > > >> It's not hard to make the problem go away by performing some simple
> > > >> action. I was unable to reproduce the problem initially because I
> > > >> checked the Smack label on the bind mounted proc entry before doing
> > > >> the cat of it. The problem shows up if nothing happens to update the
> > > >> inode.
> > > > A good point.
> > > >
> > > > I'm kinda thinking we just leave things as-is, especially since the
> > > > proposed fix isn't something anyone is really excited about.
> > > 
> > > "We have to compromise the performance of our sandboxing tool because of
> > > a kernel bug that's known and for which a fix is available."
> > > 
> > > If this were just a curiosity that wasn't affecting real development I
> > > might agree. But we've got a real world problem, and I don't see ignoring
> > > it as a good approach. I can't see maintainers of other LSMs thinking so
> > > if this were interfering with their users.
> >  
> > We do bind mount to make information exposed to the sandboxed task as little
> > as possible. We also create a separate PID namespace for each sandbox, but
> 
> If not exposing information is the main motivation, then could you simply do:
> 
> mount -t proc proc dir
> mount --bind dir/$$ dir
> 
> ?

Hi Serge,

It doesn't work.

 [root@ip-10-0-32-198 ec2-user]# mount -t proc proc dir
 [root@ip-10-0-32-198 ec2-user]# echo AAA > dir/$$/attr/current
 [root@ip-10-0-32-198 ec2-user]# chsmack dir/$$
 dir/11222 access="AAA"
 [root@ip-10-0-32-198 ec2-user]# mount --bind dir/$$ dir
 [root@ip-10-0-32-198 ec2-user]# echo BBB > dir/attr/current
 [root@ip-10-0-32-198 ec2-user]# echo CCC > dir/attr/current
 bash: dir/attr/current: Permission denied
 [root@ip-10-0-32-198 ec2-user]# ls dir
 ls: cannot access dir: Permission denied
 [root@ip-10-0-32-198 ec2-user]# 
 
It would not revalidate dir/$$ anyway, so this result wasn't surprising to
me. Maybe I'm missing something?


> > still want to bind mount even with it to hide system-wide and pid 1
> > information from the task. 
> > 
> > So, yeah, I see this as a real problem for our use case and want to seek an
> > opinion about a possibly better fix.
> > 
> > 
> > Thanks,
> > Munehisa 
> 

