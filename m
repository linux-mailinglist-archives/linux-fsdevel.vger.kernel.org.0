Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE784EDE93
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 18:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239763AbiCaQTU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 12:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239762AbiCaQTT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 12:19:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF96D1F1265;
        Thu, 31 Mar 2022 09:17:31 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22VEVZTZ032352;
        Thu, 31 Mar 2022 16:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=MHnRQMHeOiqzn6n0+jYMfnyky6jAZ1STT13/D8SmTiU=;
 b=MJPZIriGalNcbVigt4PY1RWXKiUqPyP44AHmaCcVYnIIid6ldi9CZVmCzzyI0u/8qBKK
 yCG26wNmnj1OBU5UYRSsKOf7DjBMjAT+T232ZlLYPHKxlOyAlbtRrQ+dv1vea0pQz5gw
 DJ3j4GE783i+Mx68s87tqaFrI6dnS85hnCssDUpEZ20cBs7yfEF1fNgMa2OVvXt1E6MY
 HzZ/Aw3D8osgo4Qr0KxdsSDGJhmsrQkHz3gNuw0ru8HuYvXSVSmXVZtYZOuFiXEDuOCm
 FJix/SRUJzwNCB/UnGELmFb5FOe9Tz0ffdk0AmLID8Xupg5W3AdZNh/55myUX0pcuJr/ +A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1uctw2sk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 16:17:28 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22VGG8pu013423;
        Thu, 31 Mar 2022 16:17:27 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1tg898b7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 16:17:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZdt2RwGvRiN2kWt9bnVEyMkuD6Meh09QhAvqwgWMpZaDjIJSc2Ir6XXWU0FOZEdqPE7/PR4PeLqXKtuUMcllkW1p+Fr+AzbO29ximjDjYhvBkbL5FHIQNRilGlID/PZnn0SBL/pHSYqx6ZsvHQggCThQdOG6Ai/6PEa11nQ8Nlb0V7Ctq2awkuMJ4T49ziv6nM04eyAWLk3RNnEgwTt0GB9N4KA1Kky/wP9djKN1tXxBo4qDx8b8ZWuWZgLSVf/F+tzwh6X87ckd2qG59D+WWHlg6kvYtALgQwgHIYAyCNQxXkmtLJO/+im9h4NgD5BSWKo83hvefjwhzzwrsen/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHnRQMHeOiqzn6n0+jYMfnyky6jAZ1STT13/D8SmTiU=;
 b=ZTt+4pvwV/Xpa7d9g9tLA/no29N3xDLyfeB1ofoupWOqWc2e7O+DSFyXDSsBlgs3O2/2Pu6pGDHcWMC0+K8X7H9BygBsD79jMZj4PtHIsFbTKDnicPmP7VDgvg0tB4QUlJ3xYNbNP5KQ9zTQbZhtD/X6tcxy7zomLBcp3udnMnZdxzY+PD5O3IplYDcOxfKh/2dPykcIS3WuVX2AsW4YtywxDpX7uhrVnzw2o4nHu5UgKp1L12idWUETSg9Y8Wk1bmdMQ0R2M0JGxf4GFG3NwO/qTInFCeaXP4kJD18WwPnQ01fW9witwo9DfkbNKm00la88f8yitFXH3t1PrDqUEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHnRQMHeOiqzn6n0+jYMfnyky6jAZ1STT13/D8SmTiU=;
 b=x93qnkQcmYrmvWr2ZR4IlgjGl5bXvzmb8p0n9g2pFWu9DFuGYf2CLIihoWrgD0DQTR14wApQg/bBpiEFsz7PeP5RyrU5W0hHLkB20TTzgDhWJ4Z/WN5xe7BG6s5wat2nyH7baNO3xcLTNZhKPgz2vTinwvm66oNEtvJVpio+rKs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5065.namprd10.prod.outlook.com (2603:10b6:610:c5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Thu, 31 Mar
 2022 16:17:25 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49%6]) with mapi id 15.20.5123.021; Thu, 31 Mar 2022
 16:17:25 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v19 01/11] fs/lock: add helper
 locks_owner_has_blockers to check for blockers
Thread-Topic: [PATCH RFC v19 01/11] fs/lock: add helper
 locks_owner_has_blockers to check for blockers
Thread-Index: AQHYRRixGA5f89+inU+m+Maj/AzRaqzZq2yA
Date:   Thu, 31 Mar 2022 16:17:25 +0000
Message-ID: <176D175B-7218-4B7F-85D5-1BBB4A47FC98@oracle.com>
References: <1648742529-28551-1-git-send-email-dai.ngo@oracle.com>
 <1648742529-28551-2-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1648742529-28551-2-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f77a1bc-455a-4b00-55ab-08da1331f1c7
x-ms-traffictypediagnostic: CH0PR10MB5065:EE_
x-microsoft-antispam-prvs: <CH0PR10MB5065900E3C2D7C009F06607C93E19@CH0PR10MB5065.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UyAMnqvTfABcoMXqWWodL00kYx4mUvpTY9WYWjh/qrwExflqITjw2rhu6O1lAHF+kBZqxqvVZdijt3j2svNz2oc0ILoVdALD5cTbG/ZiTTzW5vcQVnKZajDycnJjwu26WTk4ePcIXCsy1+s9BxdClCYERBn9oCh9Ptg/5uQUGBf1S2Z/RMa9qKmGyGzIdLVWvXG7gP8fmdhDmjkoAdVc6P+MPztObHdqMPMiHfMFcNOfZZ12DAZjNMkCmYnn6+FzyKPBXXWpUdwATS7qr5A4s1DQaDmKSlhDD+muwXsO6761G0KoSqPZAwupcDGojCkIrqevV8b0ReHNyD4SnX8d2MnQoVsGFjdSnI7gky4OLFrrXq/vcY+DsRAkwaPJ0gFH876oyVlsG8sKUmn5RQAlKTVWkwgMrzlX+rN9cS8WfdnAqHKcPwJoMgXEOPPpisUON1mSm8rt2BApeCklsOpYWx3cahdLu/kwnKM79KPbwnOb79KHRjob3sk7CQOg7lcTlDaDpAL9lVyvCAIROWfu3Be7VewkIsa9fQo79S/1BJcYxif6u47tnkXj3uawBpVlHSKEAlrES5fRcRp2IaseFm6D7SiEa7fO/upVquLvKUIfutuETytvQGNNBmooUw/Q71hpItx6BsM5suEKRsO19wofyZq4a8+2g0xCrHY2zxGQd0FNDdotquRoUWZgZ/5hAt4ZsYcr27PHmqr9cb1B+WB/kT1ajAGehkAvZCtjW/bZNLcZRjfGQ0oWHYczEuAj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(76116006)(2616005)(91956017)(122000001)(4326008)(6862004)(8676002)(64756008)(66446008)(66476007)(33656002)(66556008)(71200400001)(5660300002)(186003)(26005)(53546011)(2906002)(508600001)(38100700002)(6506007)(6512007)(6486002)(38070700005)(6636002)(54906003)(37006003)(8936002)(86362001)(316002)(83380400001)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?53ka9cHpC4nS8zBDusb7ZrFMdft34Yg6S0Js5psIb04y8NSWPHuWAm5rp83f?=
 =?us-ascii?Q?I4lZfcM9/in/T0F5XEetDkn5PbpjhDJCtwmWgJD7B9bnNzhHD1i6+p+WA/lG?=
 =?us-ascii?Q?4hYUodiubczkpIptKoCGcSKb3lNWvhlkIS+4oc3JV4ATupzjKzJQHkWHjwkA?=
 =?us-ascii?Q?7tgSNIsftMSyzRiCX1ACab7PzuLM7iDT0zWmFh7Ng8C3ViBEFsc9Xujilc8c?=
 =?us-ascii?Q?HU9raBl23tgUzmT5Okcs0T35iuvJmtzg9J9xT2C/ECA+Iz0XCYejv5OlMfR3?=
 =?us-ascii?Q?JFvlBwF73XhBMLYjP0xK8jeMJmI/QIEdhKC9nLj2CdE+p2OTFUV+0kb7i0Qq?=
 =?us-ascii?Q?Z5+fElNd88pY8AWOIIylBKd75t2gNqOk8ynxeR4jvuybuilU2xou2oaRpHR9?=
 =?us-ascii?Q?gJEw3yLb+SPDqE2jU3nv01u3GBJ40D9/s6qY8ha91KsQQR0ZKoouQ/36Cf8V?=
 =?us-ascii?Q?X2oZz2UGfNbxYxDj5EpIROqlSy/OREjtA53QWb8L2hI5BDtJxgXG73tanefE?=
 =?us-ascii?Q?bq6ynpov1d1DH5zEJbK9pbMtxQUdbbsFW0z03cQEn/D3f2yz5rUOL9R+4GUP?=
 =?us-ascii?Q?Xi4hlCmzvvH1RtSW3pFAW0O78jFi+VCPjN29Od5mBYmLPAUvQlkJAO5XpQzP?=
 =?us-ascii?Q?tpS+naKDO76TRSm4eZNRXyO9jtQciXk6MQaEnYOufw0ODmzrUEDmNGJnp0uz?=
 =?us-ascii?Q?0b+vzADjAaf0Wklw6mPWybF1HWvYORmZQgpEz+EbEkklBzNCmkYZMfMANKpz?=
 =?us-ascii?Q?JnRZNrN2hBHCHvXRVwLr4Wtcfews0MrWG6co2T+nkzzDcJdxD6Xm7pFxqg2q?=
 =?us-ascii?Q?Yu1qQOeLVOyLTqS++s5SbqUKnTe2wf23VAsCoFTXBoT80XLzOy/DAmCFbWVN?=
 =?us-ascii?Q?qXZL5Kfgs6xNYZxqq6w+zB+qOpjkpyLPXvdg+nZHV1jIDs70KA9HC2dPDDEJ?=
 =?us-ascii?Q?SzqEw+WaOp/9dzCA2uOZoqmsiTWGuaHKd/0hPKZdQgwQUTy8bWzPuH1e9wvq?=
 =?us-ascii?Q?35r9wxBohz8zl5Oh/7ZqgBohpPUupSY8X9btHWpTz60p0hdO3zpo2fjNJK78?=
 =?us-ascii?Q?nR857uWJufTSTPYQ+g7Vxh4Qs+WeUytKZbTW1r4DxEhjXNqrxYhXC7zNGvuy?=
 =?us-ascii?Q?DoS2njcuXbR5w4lYjH02JGc2d0E7k3e0Q8tujm6UEepum5Z3zrzveUc+a/jr?=
 =?us-ascii?Q?OBklQ3K7WuCE59JREcIHmmy1VNi0qbO1BsHbOYlhT1T93VRxGYfav/DOjv1f?=
 =?us-ascii?Q?KVwMn+61x/hRizp6MnPj+mbrIKC/ZELA1xpWdCflc11uhKHs+kU59Dj9dO8U?=
 =?us-ascii?Q?L7MmUx9Eq2QYRUleQ5EprTpedt1bAOboc+rjl4E+Wypsh76mNktOML28xURn?=
 =?us-ascii?Q?9i+8uHQsao6Rvf1FWaDUXE31GcfNgRdV5Tkzs9/H3dgeDOl26jTy0quHSXjd?=
 =?us-ascii?Q?rDDJn7uk84Kvfu/4vaRr+5I188PIcjn1+4gTgfQgNtDSZdjbWS69JGAqCKgR?=
 =?us-ascii?Q?LwpY10aZobG//D6ac3eNtPlyHUrEYKkxVIh7urQA8ShxIwXDor0oNM1XRIlZ?=
 =?us-ascii?Q?mel1I3ArWrIE+E4khxkBVuoQaNB6xZpgbVR59zFVgp9hpDulVBilwtYxW+gw?=
 =?us-ascii?Q?V3yeZQc6KjpfedTXLq52rNlnATpXgpnCLmIUIacf6nMvV7ifu44GGjjzwV1S?=
 =?us-ascii?Q?FglK/yIe+bFlWRHBPC1Wh6vtFBoSYNZEQOzdjWS5ryI5ELjUFyiR9KzRYG9v?=
 =?us-ascii?Q?lDaaQtO8D539korZD+k67gw2XOE1SUA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7A69FD83CF12E54EBE2C23B2463704E2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f77a1bc-455a-4b00-55ab-08da1331f1c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2022 16:17:25.6263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aCOY+dG5zXx+xueUE79k+pws3moB8hDUpDRTwxMPdA/NFyPSjG5AprM25pvFMK+ESYXk77wosaWsvG+KWQ1dXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5065
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-31_05:2022-03-30,2022-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203310090
X-Proofpoint-ORIG-GUID: NsNyL5BHRcR_N7bbjM-9c3WuzqJ3K6Y5
X-Proofpoint-GUID: NsNyL5BHRcR_N7bbjM-9c3WuzqJ3K6Y5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Mar 31, 2022, at 12:01 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Add helper locks_owner_has_blockers to check if there is any blockers
> for a given lockowner.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>

Since 01/11 is no longer changing and I want to keep the
Reviewed-by, I've already applied this one to for-next.

You don't need to send it again. If there is a v20,
please be sure it is rebased on my current for-next
topic branch.


> ---
> fs/locks.c         | 28 ++++++++++++++++++++++++++++
> include/linux/fs.h |  7 +++++++
> 2 files changed, 35 insertions(+)
>=20
> diff --git a/fs/locks.c b/fs/locks.c
> index 050acf8b5110..53864eb99dc5 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -300,6 +300,34 @@ void locks_release_private(struct file_lock *fl)
> }
> EXPORT_SYMBOL_GPL(locks_release_private);
>=20
> +/**
> + * locks_owner_has_blockers - Check for blocking lock requests
> + * @flctx: file lock context
> + * @owner: lock owner
> + *
> + * Return values:
> + *   %true: @owner has at least one blocker
> + *   %false: @owner has no blockers
> + */
> +bool locks_owner_has_blockers(struct file_lock_context *flctx,
> +		fl_owner_t owner)
> +{
> +	struct file_lock *fl;
> +
> +	spin_lock(&flctx->flc_lock);
> +	list_for_each_entry(fl, &flctx->flc_posix, fl_list) {
> +		if (fl->fl_owner !=3D owner)
> +			continue;
> +		if (!list_empty(&fl->fl_blocked_requests)) {
> +			spin_unlock(&flctx->flc_lock);
> +			return true;
> +		}
> +	}
> +	spin_unlock(&flctx->flc_lock);
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(locks_owner_has_blockers);
> +
> /* Free a lock which is not in use. */
> void locks_free_lock(struct file_lock *fl)
> {
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 831b20430d6e..2057a9df790f 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1200,6 +1200,8 @@ extern void lease_unregister_notifier(struct notifi=
er_block *);
> struct files_struct;
> extern void show_fd_locks(struct seq_file *f,
> 			 struct file *filp, struct files_struct *files);
> +extern bool locks_owner_has_blockers(struct file_lock_context *flctx,
> +			fl_owner_t owner);
> #else /* !CONFIG_FILE_LOCKING */
> static inline int fcntl_getlk(struct file *file, unsigned int cmd,
> 			      struct flock __user *user)
> @@ -1335,6 +1337,11 @@ static inline int lease_modify(struct file_lock *f=
l, int arg,
> struct files_struct;
> static inline void show_fd_locks(struct seq_file *f,
> 			struct file *filp, struct files_struct *files) {}
> +static inline bool locks_owner_has_blockers(struct file_lock_context *fl=
ctx,
> +			fl_owner_t owner)
> +{
> +	return false;
> +}
> #endif /* !CONFIG_FILE_LOCKING */
>=20
> static inline struct inode *file_inode(const struct file *f)
> --=20
> 2.9.5
>=20

--
Chuck Lever



