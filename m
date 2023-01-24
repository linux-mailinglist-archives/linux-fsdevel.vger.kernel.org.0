Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93AA678E74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 03:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjAXCmc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 21:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjAXCmb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 21:42:31 -0500
X-Greylist: delayed 479 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 Jan 2023 18:42:00 PST
Received: from ms11p00im-qufo17282001.me.com (ms11p00im-qufo17282001.me.com [17.58.38.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271BD3B0E5
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jan 2023 18:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1674527639;
        bh=ZHNbCgWVVT7jpGNkzvsiuGGNtXGpfKi/ODrPRk3Scp4=;
        h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
        b=coIbI4uymHXeJssODSrKoxz6FRCUt02w3YoFk/9MPmKjOT/q17DjTXFQtM5TJmbGw
         cY9v/z5W/epOACJRK3DlD1F4rGYrR9MDoKAT0noB/UdUMO047Rn4/vv3SYQ1QoDhAD
         x3+PzupR2DQcyRYOb3Mpl3uaQ30HOZjQemcs7jmQuqFcLzKelhYQHPLvQsX3S4fxDu
         ApKPpST0GDhlkVzcmL2edjLuXaUBZ/9q9GBy1tMCPUlo0Tw7QuOQaALC1EHxO9BHI8
         Q+2yoYVmFFTwI5nG+b4e8WR6Zr87aXVUKeaZK2LP38J5CBwjGG3VIE8E+jLJYDgEw2
         Y57G7sS7J8l3g==
Received: from smtpclient.apple (ms11p00im-dlb-asmtpmailmevip.me.com [17.57.154.19])
        by ms11p00im-qufo17282001.me.com (Postfix) with ESMTPSA id 5A7091E092A;
        Tue, 24 Jan 2023 02:33:58 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH v2 00/10] Performance fixes for 9p filesystem
From:   evanhensbergen@icloud.com
In-Reply-To: <4478705.9R3AOq7agI@silver>
Date:   Mon, 23 Jan 2023 20:33:46 -0600
Cc:     Zhengchao Shao via V9fs-developer 
        <v9fs-developer@lists.sourceforge.net>, asmadeus@codewreck.org,
        Ron Minnich <rminnich@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CEE93F4D-7C11-4FE3-BB70-A9C865BE5BC2@icloud.com>
References: <20221217183142.1425132-1-evanhensbergen@icloud.com>
 <20221218232217.1713283-1-evanhensbergen@icloud.com>
 <4478705.9R3AOq7agI@silver>
To:     Christian Schoenebeck <linux_oss@crudebyte.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Proofpoint-ORIG-GUID: XO9m9q2upogfFOPd73bmfT3B9_AEbpYD
X-Proofpoint-GUID: XO9m9q2upogfFOPd73bmfT3B9_AEbpYD
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-14=5F01:2022-01-14=5F01,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2301240019
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Well timed prompt, sorry =E2=80=94 I had been out of pocket while =
traveling.  The WIPs in the development branch on GitHub are me working =
my way through the dir-cache patches (which was intended as the next set =
of patches after this one) =E2=80=94 but those are complimentary to this =
set, so I=E2=80=99m about send out a [V3] without those so we can get =
this into linux-next with enough time for some more exhaustive testing =
before the next merge window.

I=E2=80=99m fine with funneling these through Dominique since he=E2=80=99s=
 currently the active maintainer, but I=E2=80=99ve also re-established =
kernel.org <http://kernel.org/> credentials so I can field the =
pull-request if desired.

          -Eric


> On Jan 23, 2023, at 10:31 AM, Christian Schoenebeck =
<linux_oss@crudebyte.com> wrote:
>=20
> On Monday, December 19, 2022 12:22:07 AM CET Eric Van Hensbergen =
wrote:
>> This is the second version of a patch series which adds a number
>> of features to improve read/write performance in the 9p filesystem.
>> Mostly it focuses on fixing caching to help utilize the recently
>> increased MSIZE limits and also fixes some problematic behavior
>> within the writeback code.
>>=20
>> Altogether, these show roughly 10x speed increases on simple
>> file transfers.  Future patch sets will improve cache consistency
>> and directory caching.
>>=20
>> These patches are also available on github:
>> https://github.com/v9fs/linux/tree/ericvh/9p-next
>>=20
>> Tested against qemu, cpu, and diod with fsx, dbench, and some
>> simple benchmarks.
>>=20
>> Signed-off-by: Eric Van Hensbergen <evanhensbergen@icloud.com>
>=20
> Hi Eric,
>=20
> what's your plan on this series? I just had a look at your github repo =
and saw
> there is a lot of stuff marked as WIP.
>=20
> Best regards,
> Christian Schoenebeck
>=20
>=20

