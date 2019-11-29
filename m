Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 871AE10D3A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2019 11:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfK2KGo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Nov 2019 05:06:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:35702 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725892AbfK2KGo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Nov 2019 05:06:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D7179B1AD;
        Fri, 29 Nov 2019 10:06:41 +0000 (UTC)
Date:   Fri, 29 Nov 2019 11:06:39 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH v2 1/3] sched/numa: advanced per-cgroup numa statistic
Message-ID: <20191129100639.GI831@blackbody.suse.cz>
References: <743eecad-9556-a241-546b-c8a66339840e@linux.alibaba.com>
 <207ef46c-672c-27c8-2012-735bd692a6de@linux.alibaba.com>
 <9354ffe8-81ba-9e76-e0b3-222bc942b3fc@linux.alibaba.com>
 <20191127101932.GN28938@suse.de>
 <3ff78d18-fa29-13f3-81e5-a05537a2e344@linux.alibaba.com>
 <20191128123924.GD831@blackbody.suse.cz>
 <e008fef6-06d2-28d3-f4d3-229f4b181b4f@linux.alibaba.com>
 <20191128155818.GE831@blackbody.suse.cz>
 <b97ce489-c5c5-0670-a553-0e45d593de2c@linux.alibaba.com>
 <f9da5ce8-519e-62b4-36f7-8e5bbf0485fd@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tctmm6wHVGT/P6vA"
Content-Disposition: inline
In-Reply-To: <f9da5ce8-519e-62b4-36f7-8e5bbf0485fd@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--tctmm6wHVGT/P6vA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2019 at 01:19:33PM +0800, =E7=8E=8B=E8=B4=87 <yun.wang@linu=
x.alibaba.com> wrote:
> I did some research regarding cpuacct, and find cpuacct_charge() is a good
> place to do hierarchical update, however, what we get there is the execut=
ion
> time delta since last update_curr().
I wouldn't extend cpuacct, I'd like to look into using the rstat
mechanism for per-CPU runtime collection. (Most certainly I won't get
down to this until mid December though.)

> I'm afraid we can't just do local/remote accumulation since the sample pe=
riod
> now is changing, still have to accumulate the execution time into locality
> regions.
My idea was to decouple time from the locality counters completely. It'd
be up to the monitoring application to normalize differences wrt
sampling rate (and handle wrap arounds).


Michal

--tctmm6wHVGT/P6vA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl3g7aoACgkQia1+riC5
qSj6ihAAjGL+AfasV1mBclWNhpl6+ocgSIbO11onVPt4IbQHizY925prKB3WfEqc
n/rv5OykoWSLCtZsSQAzqN7th9XYzqaALVJ7/CDfQP4QBIlPxBQ/nSQvE1mg5f5e
Dyon80A94xAxWScMCXhpL1BgmNJH9PxgI/1rVq0RuAn2OE5XN/95xzesZh89SWLa
A8iJ/4rvUwF7aQZLpG75U03Kejo16aBPcaSh8M9dqCPTa9R0/iXMc20bzVBhpqZq
GvT+V5NjgOmM4mxwa1atcOXdsb5w+J3NRTxl4fl8rwr01WTwR6OiU2ZTV3+OMqwe
DK0UaLdwKc9X7uzioPiVZlICOz8lBccd19ZvmMUVPgZdwIfXLT52S30dp38gq6vd
RVOGf68MWI0swndpgnVcSHpSyIgMOvQBdWaA0Yv8GkfIcADwCceeFQ0joyhm+SbU
wnhfEB6/gwWn5CU9bhhNJF2yILxxmQYfjE4hgkMg4fvdddisAvha7AVDYS5dXadW
xSnvCXgI1gRXm4SmF8SmuLDVsLdmFJf2OIjKBbOZ2lY1yxnO66bc/cSKQZlYGyVg
7cFZDhjUCKPEys1sn7SwV4KGpa9AQVBL18D6AvAAwnWRxJxPdSJP2lKB0u4sIDJQ
kqGtI30Ny4C8ClB1XqB1YAMHYjObuuGfBG0NtCLap6bOxI0hdc0=
=+0n3
-----END PGP SIGNATURE-----

--tctmm6wHVGT/P6vA--
