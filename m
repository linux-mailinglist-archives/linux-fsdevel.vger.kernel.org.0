Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA41CEEC2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 00:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbfJGWD3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Oct 2019 18:03:29 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40890 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728422AbfJGWD3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Oct 2019 18:03:29 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x97M0L1P002970;
        Mon, 7 Oct 2019 15:02:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=c9OFU67Nme12ss2a2e2CJGmIEWpJhOcZpPtuepV8Kc4=;
 b=VZjzhTDszYoveecWeqlVaWomlIyjRGiKi1GVwIvQ6mEK4N+HFwb/4P5dakHVnd912aTV
 nVtEmbou/YVtPyO5OVpKJQz2f761p9WRSyrDPIkt7Zq2ge4yrnhOkBBJs99/vt4hplai
 hcMCJKF7SzaMwzyu7AcKDfjY77fRDwy1e5o= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vgbjx8k16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 07 Oct 2019 15:02:49 -0700
Received: from ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) by
 ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 7 Oct 2019 15:02:48 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 7 Oct 2019 15:02:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkImLnXmZe19zooANgU9mM/gQLz4KuTZHtMnF/CWAlSL5/KQfFjNsrwsjNJEkhPbWvzbYIWLwVXy2Cwn0VNRcvP1j4aWVrkagpiJ767QT40+0iLjgl3M4kRU/iitqQNvONpbZX5H3UESfb61E/mb76ZMk++cQSovgUb8sSIqGPjN8KZmmFK8ANErVhRzLKrEyhJtYfFxgzVdLMKVrYqqFSuS0dNQ/KYAS8gCgVzF2zSp2OYZma+8C+NxBUKCLf2KWExqvEuzsNjrgdT0Yk9sEAeYyBS7be9bQTgEyc0RBN9LpZ52NU//1LYNQMkVtxXB//mRSLt/ohK9KoNG9Poqnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9OFU67Nme12ss2a2e2CJGmIEWpJhOcZpPtuepV8Kc4=;
 b=DZdXZ0yDupa6EGgQTqQKrno2copM9QaLz2qU+Q4BAMlzVG4bCXYEvuJ2yWC4UGjCy+5iT5XQ5fuqSkru1qL1lxFWgRatvceVT/m1GRPMKnq6hPaCAMZgwPugunDM27TXoPuHW47c/IbWEMeuOvbK+JPLyrmA6GL6dtnciAS2bKhbXKC59ISUWOrBtVWL7modc1iOH9+GQsrDFf+iSRbTZ6zWgX1gLosZooV3AAvlIjJBp0Rmkow0Nn5YATzlvqwZ76EfH3day8SCzLhjAH13cP7BfHeP+D5v/hP119IH7xLuYaQGUmOkKOBg4tOXpSzSktII0ewIpXxCejsc92yfOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9OFU67Nme12ss2a2e2CJGmIEWpJhOcZpPtuepV8Kc4=;
 b=Eu73t2sRPqjW68okeyBAOhjPl//zLN4nPknPoPFi+DKn2D/5zRH/vE/Vgpv7Y6hbET6d62RWLtpT9H2YrgVhm6HR9relOjA1f29c2wrfcFcad8AmU5Yw7q+WJCRDGU0bCQDPTEuSyYjkmRYwNV5ZmMbtELXaetPIvYlZjdKBaFE=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB2932.namprd15.prod.outlook.com (20.178.222.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Mon, 7 Oct 2019 22:02:46 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::dde5:821f:4571:dea4]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::dde5:821f:4571:dea4%5]) with mapi id 15.20.2327.023; Mon, 7 Oct 2019
 22:02:46 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Hillf Danton <hdanton@sina.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "tj@kernel.org" <tj@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] cgroup, blkcg: prevent dirty inodes to pin dying memory
 cgroups
Thread-Topic: [PATCH] cgroup, blkcg: prevent dirty inodes to pin dying memory
 cgroups
Thread-Index: AQHVfNS/K+Vdy4pObUu1FttqCOATf6dPvDgA
Date:   Mon, 7 Oct 2019 22:02:46 +0000
Message-ID: <20191007220242.GA25914@tower.DHCP.thefacebook.com>
References: <20191007060144.12416-1-hdanton@sina.com>
In-Reply-To: <20191007060144.12416-1-hdanton@sina.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR19CA0052.namprd19.prod.outlook.com
 (2603:10b6:300:94::14) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:e5d8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e89d44be-4cb7-4b95-1eba-08d74b7215ed
x-ms-traffictypediagnostic: BN8PR15MB2932:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR15MB2932E6C0AC6E18CC2C5724F4BE9B0@BN8PR15MB2932.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01834E39B7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(346002)(376002)(396003)(189003)(199004)(6916009)(52116002)(305945005)(6436002)(6246003)(446003)(11346002)(486006)(476003)(102836004)(46003)(14454004)(186003)(7736002)(6486002)(6512007)(316002)(9686003)(54906003)(25786009)(99286004)(478600001)(229853002)(33656002)(76176011)(66946007)(5660300002)(81156014)(6116002)(81166006)(8676002)(6506007)(386003)(256004)(64756008)(8936002)(66476007)(66556008)(2906002)(66446008)(71190400001)(14444005)(1076003)(71200400001)(4326008)(5024004)(86362001)(14143004);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB2932;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: inobzCp4faM3ICVtT+VeB4tWBzfDb12XHUtyRkwhiSg30m+4WoWbOvbcFLsteV6/+Df8h3b4za9Z2exqZW4JJRQhxlK8BKWiVi7y9/HtYzWxmjhA6/MPH5pTT/9XmJGzb9ONnFsr5jv6CtvzhYKG4OJFuxre37avvAEcVwN7fLbQxQTT55dK1rBZOUFhbm/ds2h6OnXLlNKHizyRkGcc9NZzRF5v2qvrIMS8pXKSEqwhHLVYk0Fq8Jlc3Au+dvKcCseOwxZ8m/79KPl2bPrRoppwIRNOa2VQzcYhm0/oWUi3g3f+oTn8CgRRoqwSDTrpsEdCIx5q+7ImRqDwEfSb1GFGwL+rd5rPl/tEfHldHK07ZJk6Lo6HGmA9E1mGlGg3m912qTo2mw+L8zXahW7JkXMbptlFjjFXknp2kkS7MvU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8292DFBB9E86F34D971A322BBFA4A9E8@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e89d44be-4cb7-4b95-1eba-08d74b7215ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2019 22:02:46.4969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wKirTGemFppks5JVhU7rsnyWFidx/78hEv4oJq4gmbz+46I86j+YzMvFKqtwR07J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2932
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-07_04:2019-10-07,2019-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 suspectscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910070196
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 07, 2019 at 02:01:44PM +0800, Hillf Danton wrote:
>=20
> On Fri, 4 Oct 2019 15:11:04 -0700 Roman Gushchin wrote:
> >=20
> > This is a RFC patch, which is not intended to be merged as is,
> > but hopefully will start a discussion which can result in a good
> > solution for the described problem.
> > --
> > We've noticed that the number of dying cgroups on our production hosts
> > tends to grow with the uptime. This time it's caused by the writeback
> > code.
> >=20
> > An inode which is getting dirty for the first time is associated
> > with the wb structure (look at __inode_attach_wb()). It can later
> > be switched to another wb under some conditions (e.g. some other
> > cgroup is writing a lot of data to the same inode), but generally
> > stays associated up to the end of life of the inode structure.
> >=20
> > The problem is that the wb structure holds a reference to the original
> > memory cgroup. So if the inode was dirty once, it has a good chance
> > to pin down the original memory cgroup.
> >=20
> > An example from the real life: some service runs periodically and
> > updates rpm packages. Each time in a new memory cgroup. Installed
> > .so files are heavily used by other cgroups, so corresponding inodes
> > tend to stay alive for a long. So do pinned memory cgroups.
> > In production I've seen many hosts with 1-2 thousands of dying
> > cgroups.
>=20
> The diff below fixes e8a7abf5a5bd ("writeback: disassociate inodes
> from dying bdi_writebacks") by selecting new memcg_css id for dying
> bdi_writeback to switch to.
> Checking offline memcg is also added, which is perhaps needed in your
> case. Let us know if it makes sense in helping you cut dying cgroups
> down a bit.

Hello, Hillf!

Thank you for the patch! I'll be back with testing results in few days.
I doubt that it can completely solve the problem (if nobody is using
the inode for writing), but probably can make it less noticeable.

Thanks!

>=20
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -552,6 +552,8 @@ out_free:
>  void wbc_attach_and_unlock_inode(struct writeback_control *wbc,
>  				 struct inode *inode)
>  {
> +	int new_id =3D 0;
> +
>  	if (!inode_cgwb_enabled(inode)) {
>  		spin_unlock(&inode->i_lock);
>  		return;
> @@ -560,6 +562,22 @@ void wbc_attach_and_unlock_inode(struct
>  	wbc->wb =3D inode_to_wb(inode);
>  	wbc->inode =3D inode;
> =20
> +	if (unlikely(wb_dying(wbc->wb)) ||
> +	    !mem_cgroup_from_css(wbc->wb->memcg_css)->cgwb_list.next) {
> +		int id =3D wbc->wb->memcg_css->id;
> +		/*
> +		 * any css id is fine in order to let dying/offline
> +		 * memcg reap
> +		 */
> +		if (id !=3D wbc->wb_id && wbc->wb_id)
> +			new_id =3D wbc->wb_id;
> +		else if (id !=3D wbc->wb_lcand_id && wbc->wb_lcand_id)
> +			new_id =3D wbc->wb_lcand_id;
> +		else if (id !=3D wbc->wb_tcand_id && wbc->wb_tcand_id)
> +			new_id =3D wbc->wb_tcand_id;
> +		else
> +			new_id =3D inode_to_bdi(inode)->wb.memcg_css->id;
> +	}
>  	wbc->wb_id =3D wbc->wb->memcg_css->id;
>  	wbc->wb_lcand_id =3D inode->i_wb_frn_winner;
>  	wbc->wb_tcand_id =3D 0;
> @@ -574,8 +592,8 @@ void wbc_attach_and_unlock_inode(struct
>  	 * A dying wb indicates that the memcg-blkcg mapping has changed
>  	 * and a new wb is already serving the memcg.  Switch immediately.
>  	 */
> -	if (unlikely(wb_dying(wbc->wb)))
> -		inode_switch_wbs(inode, wbc->wb_id);
> +	if (new_id)
> +		inode_switch_wbs(inode, new_id);
>  }
>  EXPORT_SYMBOL_GPL(wbc_attach_and_unlock_inode);
> =20
> --
>=20
>=20
