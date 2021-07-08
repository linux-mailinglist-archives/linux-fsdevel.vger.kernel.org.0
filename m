Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B142F3BF9FD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jul 2021 14:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhGHM0o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jul 2021 08:26:44 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:55699 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbhGHM0o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jul 2021 08:26:44 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210708122401epoutp0188006957bb589e9aa56740b65685bcd5~P0FH9Zkah1955519555epoutp01S
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jul 2021 12:24:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210708122401epoutp0188006957bb589e9aa56740b65685bcd5~P0FH9Zkah1955519555epoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1625747041;
        bh=oOzJuWcMwSuh+8AAaknnVD1lxN/Rb96+3VUoj6XrcMs=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=qipmtqF1bY1isP3m3vRGNwpUZ4ygnEE5IjZ0Bp84HLau80DrbCXGAeP21ZDLXYNwK
         vViVh0gg9rL8myMhcwAhpGlVS9aYhajgePHOkw3tck4j+hCacIAW6XcT1ITlpPk9nB
         nsZyQc5GVaLEN2ExeenYWTJPKBo0I7BRUxuCoC5E=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210708122400epcas1p206fcd4f6e3a01e67906f20dbc4d49e15~P0FHabrb52304823048epcas1p2s;
        Thu,  8 Jul 2021 12:24:00 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.164]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4GLFp73xczz4x9Pv; Thu,  8 Jul
        2021 12:23:59 +0000 (GMT)
X-AuditID: b6c32a39-86dff70000002572-44-60e6ee5fa5a6
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        8E.DB.09586.F5EE6E06; Thu,  8 Jul 2021 21:23:59 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH] connector: send event on write to /proc/[pid]/comm
Reply-To: ohoono.kwon@samsung.com
Sender: =?UTF-8?B?6raM7Jik7ZuI?= <ohoono.kwon@samsung.com>
From:   =?UTF-8?B?6raM7Jik7ZuI?= <ohoono.kwon@samsung.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        =?UTF-8?B?6raM7Jik7ZuI?= <ohoono.kwon@samsung.com>
CC:     "mingo@kernel.org" <mingo@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "ohkwon1043@gmail.com" <ohkwon1043@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <8735sxoh7j.fsf@disp2133>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20210708122359epcms1p2aa0ae62f2476e18ca63bdc48a0bb2050@epcms1p2>
Date:   Thu, 08 Jul 2021 21:23:59 +0900
X-CMS-MailID: 20210708122359epcms1p2aa0ae62f2476e18ca63bdc48a0bb2050
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmgW78u2cJBufny1rMWb+GzWLrt0SL
        OedbWCz+b2tht9iz9ySLxeVdc9gsVv87xWixd7+vxa6fK5gdOD22rLzJ5LFz1l12j02rOtk8
        Tsz4zeLRt2UVo8eDSW8YPT5vkvOYcqidJYAjKscmIzUxJbVIITUvOT8lMy/dVsk7ON453tTM
        wFDX0NLCXEkhLzE31VbJxSdA1y0zB+g6JYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpB
        Sk6BoUGBXnFibnFpXrpecn6ulaGBgZEpUGVCTsbkPzsZC2YpVOx/84GtgXGlfBcjJ4eEgInE
        5Ann2boYuTiEBHYwSiw6cYG1i5GDg1dAUOLvDmGQGmEBd4mlc54zg4SFBBQltp12gwhbSUzr
        +8cEYrMJWEg8X/uTFcQWEUiVWDLlPgvISGaBdmaJnoNXWSB28UrMaH8KZUtLbF++lRHE5hRQ
        k1jw6DorRFxU4ubqt+ww9vtj8xkhbBGJ1ntnmSFsQYkHP3dDxSUlbrbdBVsmIdDPKHF/XQuU
        M4FRYsmTSWwQVeYSzza0gE3lFfCVOP/4L9jZLAKqEts2/wd7WELAReJPcyFImFlAW2LZwtdg
        DzMLaEqs36UPMUVRYufvuYwQJXwS7772sML8tWPeEyaIKaoSy357wLzYN/0yG0TYQ2LNO1FI
        KG9klHjb/pZlAqPCLERAz0KydxbC3gWMzKsYxVILinPTU4sNC0yR43YTIzihalnuYJz+9oPe
        IUYmDsZDjBIczEoivEYzniUI8aYkVlalFuXHF5XmpBYfYjQFengis5Rocj4wpeeVxBuaGhkb
        G1uYmJmbmRorifPuZDuUICSQnliSmp2aWpBaBNPHxMEp1cC0kdshi2XbITHnO7sWlApkrb1d
        9F972YzFedd3np7YUnL4q/yFmA3sP2S/Tr7yhSv9gXPYrn+quvZcL7vFjz4zTtyd+UdHbIGi
        +BZPz5Pc7BI8B4P+H8vtPvVNh++qxeTjKwTl7z9syji3/LKbZdUx6WoZKXVN7hunp54LNVI6
        3+mcn1DwmOFa1bIrhbPXXX0UND3RUdqRX6KHe/b/bh0JnUXuXJn9IQW3WS3PKSxUfdywxSTN
        MtLiw6ytt3y0r/t9/7Zw/bQ2x3U6k/2tG3r5NydzhDufL3rsvir0wcnUy/P7fp27mOwlteXR
        oZaTax47reKPuJ26omfBFKOZWfvjVPbeSLkxw33dldDN1yRClFiKMxINtZiLihMB5/yPmjEE
        AAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210701133458epcms1p68e9eb9bd0eee8903ba26679a37d9d960
References: <8735sxoh7j.fsf@disp2133>
        <20210701133458epcms1p68e9eb9bd0eee8903ba26679a37d9d960@epcms1p6>
        <CGME20210701133458epcms1p68e9eb9bd0eee8903ba26679a37d9d960@epcms1p2>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric W. Biederman <ebiederm=40xmission.com> writes:=20
> =EA=B6=8C=EC=98=A4=ED=9B=88=20<ohoono.kwon=40samsung.com>=20writes:=0D=0A=
>=20>=20=0D=0A>=20>=20>=20While=20comm=20change=20event=20via=20prctl=20has=
=20been=20reported=20to=20proc=20connector=20by=0D=0A>=20>=20'commit=20f786=
ecba4158=20(=22connector:=20add=20comm=20change=20event=20report=20to=20pro=
c=0D=0A>=20>=20connector=22)',=20connector=20listeners=20were=20missing=20c=
omm=20changes=20by=20explicit=0D=0A>=20>=20writes=20on=20/proc/=5Bpid=5D/co=
mm.=0D=0A>=20>=0D=0A>=20>=20Let=20explicit=20writes=20on=20/proc/=5Bpid=5D/=
comm=20report=20to=20proc=20connector.=0D=0A>=20=0D=0A>=20Is=20connector=20=
really=20useful?=20=20I=20am=20under=20the=20impression=20that=20connector=
=0D=0A>=20did=20not=20get=20much=20if=20any=20real=20uptake=20of=20users.=
=0D=0A>=20=0D=0A>=20I=20know=20the=20impression=20that=20connector=20is=20n=
ot=20used=20and=20that=20there=0D=0A>=20are=20generally=20better=20mechanis=
ms=20for=20what=20it=20provides=20has=20led=20to=0D=0A>=20connector=20not=
=20getting=20any=20namespace=20support.=20=20Similarly=20bugs=0D=0A>=20like=
=20the=20one=20you=20just=20have=20found=20persist.=0D=0A>=20=0D=0A>=20If=
=20connector=20is=20actually=20useful=20then=20it=20is=20worth=20fixing=20l=
ittle=20things=0D=0A>=20like=20this.=20=20But=20if=20no=20one=20is=20really=
=20using=20connector=20I=20suspect=20a=20better=0D=0A>=20patch=20direction=
=20would=20be=20to=20start=20figuring=20out=20how=20to=20deprecate=20and=0D=
=0A>=20remove=20connector.=0D=0A>=20=0D=0A>=20Eric=0D=0A=0D=0ADear=20Eric.=
=0D=0A=0D=0AI=20get=20your=20point,=20and=20I=20can=20also=20see=20that=20/=
drivers/connector=20directory=20has=0D=0Anot=20been=20modified=20since=20la=
st=20December,=20which=20might=20imply=20that=20not=20so=20many=0D=0Ausers=
=20are=20actively=20paying=20attention=20to=20the=20connector.=0D=0A=0D=0AH=
owever=20in=20Samsung,=20we=20are=20currently=20using=20connector=20feature=
=20for=20our=0D=0Aproprietary=20solution,=20which=20uses=20it=20to=20receiv=
e=20kernel=20events=20such=20as=20fork,=0D=0Aexec,=20and=20comm=20changes=
=20at=20userspace=20daemon.=0D=0A=0D=0ASince=20I=20am=20new=20to=20patching=
=20linux=20kernel,=20I=20cannot=20say=20much=20about=20whether=0D=0Aconnect=
or=20should=20be=20deprecated=20or=20not.=20I=20guess=20it=20is=20up=20to=
=20all=20of=20you=20guys=0D=0Awho=20have=20contributed=20to=20the=20connect=
or=20driver=20to=20discuss=20and=20decide.=0D=0A=0D=0AMeanwhile,=20I=20stil=
l=20think=20bugfixes=20should=20be=20applied=20until=20the=20feature=20is=
=0D=0Aactually=20decided=20to=20be=20deprecated.=0D=0A=0D=0AThanks,=0D=0AOh=
hoon=20Kwon.=0D=0A=0D=0A>=20=0D=0A>=20=0D=0A>=20>=20Signed-off-by:=20Ohhoon=
=20Kwon=20<ohoono.kwon=40samsung.com>=0D=0A>=20>=20---=0D=0A>=20>=20=20fs/p=
roc/base.c=20=7C=205=20++++-=0D=0A>=20>=20=201=20file=20changed,=204=20inse=
rtions(+),=201=20deletion(-)=0D=0A>=20>=0D=0A>=20>=20diff=20--git=20a/fs/pr=
oc/base.c=20b/fs/proc/base.c=0D=0A>=20>=20index=209cbd915025ad..3e1e6b56aa9=
6=20100644=0D=0A>=20>=20---=20a/fs/proc/base.c=0D=0A>=20>=20+++=20b/fs/proc=
/base.c=0D=0A>=20>=20=40=40=20-95,6=20+95,7=20=40=40=0D=0A>=20>=20=20=23inc=
lude=20<linux/posix-timers.h>=0D=0A>=20>=20=20=23include=20<linux/time_name=
space.h>=0D=0A>=20>=20=20=23include=20<linux/resctrl.h>=0D=0A>=20>=20+=23in=
clude=20<linux/cn_proc.h>=0D=0A>=20>=20=20=23include=20<trace/events/oom.h>=
=0D=0A>=20>=20=20=23include=20=22internal.h=22=0D=0A>=20>=20=20=23include=
=20=22fd.h=22=0D=0A>=20>=20=40=40=20-1674,8=20+1675,10=20=40=40=20static=20=
ssize_t=20comm_write(struct=20file=20*file,=20const=20char=20__user=20*buf,=
=0D=0A>=20>=20=20=09if=20(=21p)=0D=0A>=20>=20=20=09=09return=20-ESRCH;=0D=
=0A>=20>=20=20=0D=0A>=20>=20-=09if=20(same_thread_group(current,=20p))=0D=
=0A>=20>=20+=09if=20(same_thread_group(current,=20p))=20=7B=0D=0A>=20>=20=
=20=09=09set_task_comm(p,=20buffer);=0D=0A>=20>=20+=09=09proc_comm_connecto=
r(p);=0D=0A>=20>=20+=09=7D=0D=0A>=20>=20=20=09else=0D=0A>=20>=20=20=09=09co=
unt=20=3D=20-EINVAL;=0D=0A=0D=0A
