Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8CA27A599
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Sep 2020 05:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgI1DAJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Sep 2020 23:00:09 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:45322 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgI1DAI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Sep 2020 23:00:08 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08S2sATh047155;
        Mon, 28 Sep 2020 02:59:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=quUjA9UP3lIGrb1L1O9MnpSNx1YBF6qZPnmq+PQW1Z8=;
 b=nZRyH184Duw0ByJbsmvAZpTFkO40Q7oE0/TkmFXcDEKin1jowsivTkTyqcL4thOOFu5k
 dBmdOL7NOZf21rGzmJrFijKZu237kA00FHUOzDrWBQkoCw0HsVFEuiOZvuQBfCMEP+1q
 AXpBiRRTAxvSN57vCRGt0G1q1cQIzHrsw0keEJ/kGW+arPj/SsIUOeLyw7hV/FGJjEEe
 AM7Ag4sGVhJwgpkmxiCMnvPQjlEiyzJAxnqGJrjgMdb86jAeDj8mkCLYVrd+kBvHcYW8
 0YbDaYOmRwpHcNN8upjXKUXZHbfXMiyTVCx5IsQHy14N5VA4qtdNsc/lgw49/isKQkBz 7g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 33su5ajv6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Sep 2020 02:59:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08S2seaU031019;
        Mon, 28 Sep 2020 02:59:55 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 33tfdpb3a3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Sep 2020 02:59:54 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08S2xpBY022749;
        Mon, 28 Sep 2020 02:59:51 GMT
MIME-Version: 1.0
Message-ID: <061c43fb-5f0d-4d4f-85ca-5fff2ef6f4db@default>
Date:   Sun, 27 Sep 2020 19:59:51 -0700 (PDT)
From:   Tom Hromatka <tom.hromatka@oracle.com>
To:     <tglx@linutronix.de>
Cc:     <mingo@kernel.org>, <fweisbec@gmail.com>, <adobriyan@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] /proc/stat: Simplify iowait and idle calculations
 when cpu is offline
X-Mailer: Zimbra on Oracle Beehive
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9757 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009280023
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9757 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=1
 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009280023
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

My sincere apologies.  2020 has been a challenging year for
my family and me, and I readily admit that I have struggled
with all of the added stress.  I realize and acknowledge that
this is not an acceptable excuse for a patchset that doesn't
hold up to the kernel or my standards.

Thank you for your time and your sincere response.

Best regards,

Tom


----- Original Message -----
From: tglx@linutronix.de
To: tom.hromatka@oracle.com, tom.hromatka@oracle.com, linux-kernel@vger.ker=
nel.org, linux-fsdevel@vger.kernel.org, fweisbec@gmail.com, mingo@kernel.or=
g, adobriyan@gmail.com
Sent: Thursday, September 24, 2020 3:19:58 PM GMT -07:00 US/Canada Mountain
Subject: Re: [PATCH v2 2/2] /proc/stat: Simplify iowait and idle calculatio=
ns when cpu is offline

On Tue, Sep 15 2020 at 13:36, Tom Hromatka wrote:
> Prior to this commit, the cpu idle and iowait data in /proc/stat used
> different data sources based upon whether the CPU was online or not.
> This would cause spikes in the cpu idle and iowait data.

This would not cause spikes. It _causes_ these times to go backwards and
start over from 0. That's something completely different than a spike.

Please describe problems precisely.

> This patch uses the same data source, get_cpu_{idle,iowait}_time_us(),
> whether the CPU is online or not.
>
> This patch and the preceding patch, "tick-sched: Do not clear the
> iowait and idle times", ensure that the cpu idle and iowait data
> are always increasing.

So now you have a mixture of 'This commit and this patch'. Oh well.

Aside of that the ordering of your changelog is backwards. Something
like this:

   The CPU idle and iowait times in /proc/stats are inconsistent accross
   CPU hotplug.

   The reason is that for NOHZ active systems the core accounting of CPU
   idle and iowait times used to be reset when a CPU was unplugged. The
   /proc/stat code tries to work around that by using the corresponding
   member of kernel_cpustat when the CPU is offline.

   This works as long as the CPU stays offline, but when it is onlined
   again then the accounting is taken from the NOHZ core data again
   which started over from 0 causing both times to go backwards.

   The HOHZ core has been fixed to preserve idle and iowait times
   accross CPU unplug, so the broken workaround is not longer required.

Hmm?

But...

> --- a/fs/proc/stat.c
> +++ b/fs/proc/stat.c
> @@ -47,34 +47,12 @@ static u64 get_iowait_time(struct kernel_cpustat *kcs=
, int cpu)
> =20
>  static u64 get_idle_time(struct kernel_cpustat *kcs, int cpu)
>  {
> -=09u64 idle, idle_usecs =3D -1ULL;
> -
> -=09if (cpu_online(cpu))
> -=09=09idle_usecs =3D get_cpu_idle_time_us(cpu, NULL);
> -
> -=09if (idle_usecs =3D=3D -1ULL)
> -=09=09/* !NO_HZ or cpu offline so we can rely on cpustat.idle */
> -=09=09idle =3D kcs->cpustat[CPUTIME_IDLE];
> -=09else
> -=09=09idle =3D idle_usecs * NSEC_PER_USEC;
> -
> -=09return idle;
> +=09return get_cpu_idle_time_us(cpu, NULL) * NSEC_PER_USEC;

Q: How is this supposed to work on !NO_HZ systems or in case that NOHZ
   has been disabled at boot time via command line option or lack of
   hardware?

A: Not at all.

Hint #1: You removed the following comment:

=09/* !NO_HZ or cpu offline so we can rely on cpustat.idle */

Hint #2: There is more than one valid kernel configuration.
'
Hint #3: Command line options and hardware features have side effects

Hint #4: git grep 'get_cpu_.*_time_us'=20

Thanks,

        tglx

