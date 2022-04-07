Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C844F8807
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 21:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiDGT0n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 15:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiDGT0h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 15:26:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA8B279715;
        Thu,  7 Apr 2022 12:24:28 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 237GeoAv012570;
        Thu, 7 Apr 2022 19:24:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=i5T0adGNdzMK9Epp3UbeavmHWFdKiQOILL0nT23dP/E=;
 b=Lje/rJiR+nraAKMf16mwmQMK1611c6G/HeVupMfiH9U4u6nl0yJ6ENSsGO4Bdt000LcX
 ugTkUxKXXy9B1vil1qTIONmHVluRLYWAC4WVegs8QvbSjNJumMlxR+87mrT+I4mrxLhM
 OmPmfwLZshdPrIMhNS592+SfxjYBSLSX4VCfQL3z4TZ7RSU3WVQFeOFwgFZ28V7qZ4Zo
 wmJrJ6vFq50pWf/0IADDalqp0kysrqA7zeVhzBcHeF951OSRlXiubWcPwzKtIdI7l7dd
 1AxL1IyoOXDvBsxAG9axdbvO/LtYIsz4QyCAq+fA+O59pH4H7WE3sUWdo603lWVK1v1X vA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6cwcmjay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 19:24:14 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 237JAM9v027411;
        Thu, 7 Apr 2022 19:24:14 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f9804e83c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 19:24:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfFIDORlADE9u1imH2Ik2fMR7kaDg2zHvJksdYeEvbqcpmO2IlOQqC49ShJjCjZ9KQOzySPcrKtsqPgfkXZyqlPbYKyCgDVOqIb+4ZR4pSCPOZcwKonzSujpZaBxh5RFMrX1bUbRs7e8tVK/VPBLeDJLzSqX03IqhM2MMG2Gd5ZBluMUJAyJSMKN0M1reTU5YV1hcHRl7aGO5DTiWiwAkDJH5NuFAJtfDPZhj1jOWynUcP5xibbU+8aQCqPHQpJp2PiJBNPUEczSMgZqW4xqexLIKyQGS2JErAyB3H6s5zEXekrw1+HWg46iIlZ3TUHX2CgSFuhaIBBdmAdEu0oxMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5T0adGNdzMK9Epp3UbeavmHWFdKiQOILL0nT23dP/E=;
 b=nA7seTK9d4EdNT1ywQvo4VEyLEpQfrL3JEhKL9v7z6q7ReyRzUjZUp1TUYGADWIiLzcDdnNw5K/0UWCLhK5gq+XDtNe8BnF4adH0THORguAbxBG8SQenxSAXTpxMVqu5Gf26aahwM7NzCx/Tczf4e4njGoxIUGjKJYIJ/LBnQXX3u0pQSREK5p02K2D2yj0Uhrel3Yujrxupz1+41lDdZ34gQISf/LqY8w1cx8Ek/VyNJjtxEi8B7Apptv2nkxARheKl4cS+BEQuNdw3HhUnPqYZw04EAzygKkk1wgAxZu/gmqHiQJE2jeQf3JWmiFFHPSSneW4lVrubAQxYATKPhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5T0adGNdzMK9Epp3UbeavmHWFdKiQOILL0nT23dP/E=;
 b=jr0Pzs481CyINxkCk0n8Y9hLQw+HrIBsfUsEULng4eTzf+4z/RNctjMygLFXIHacf8ci2xrlcRZsmldXHMubRDl7diJ8IqTlc0HFS8brYl+3rdCVbP1sOkG4CJhFA9/2mCstpZ1LIb/+XKLTi/fiBnS9q/3Acu2zrRYCgLN7L0Q=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5228.namprd10.prod.outlook.com (2603:10b6:610:db::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Thu, 7 Apr
 2022 19:24:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49%7]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 19:24:11 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Hugh Dickins <hughd@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Patrice CHOTARD <patrice.chotard@foss.st.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: Regression in xfstests on tmpfs-backed NFS exports
Thread-Topic: Regression in xfstests on tmpfs-backed NFS exports
Thread-Index: AQHYSdpNL2d3Xru4B0OzHZJ1LCngEazjlm2AgAE//IA=
Date:   Thu, 7 Apr 2022 19:24:11 +0000
Message-ID: <2B7AF707-67B1-4ED8-A29F-957C26B7F87A@oracle.com>
References: <673D708E-2DFA-4812-BB63-6A437E0C72EE@oracle.com>
 <11f319-c9a-4648-bfbb-dc5a83c774@google.com>
In-Reply-To: <11f319-c9a-4648-bfbb-dc5a83c774@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c567f16-7622-4867-5ff5-08da18cc3214
x-ms-traffictypediagnostic: CH0PR10MB5228:EE_
x-microsoft-antispam-prvs: <CH0PR10MB5228E0FA14AEF3DE95D44B9593E69@CH0PR10MB5228.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T/pupD3fciugBnrJ3SbfUZy6VhCF84BNAHnZFJ7pJuCotisXVYcSwMB4Da214vp9QOsr8KtFHxTPnh4OtYOQ47cjYUiNJriA7QjMV4KmtDT9oX+a+wjvbTr3G3DducalrQ7SoZJSsziajNUer4LefHi0FzlSP0w2miVCFLL0P4Fh1ItWXhe2APaH0WvYk62TdOOayke0vwwBsgb6FSB+x7LOLt319G0vSGM/TEtdncPpsLut6fzvZ6pnlAvnkU1jLvMKqMlW5590G8BTQGYt+9OBsacrZoo7X5A1D8gxNae1wqEzjnxA1H3CuV+nSX1fxBkeS3xmEm78dROo56pxmm1jmS3yz14EmTGCcNKmvgZ5sY6WxskJtxtLvsekDZ/faWZqkM3VWkuUGuNOQo2M1wIxtAa9ZFsViiA1/wWFUyREbwc7HbREYejVmtwSeNFR0/tHJf+1l2pxXa2XhhlSdZzx8XzMpuIVKyiyE3Um8lUTAKLo+8anT85GEv8kBzz6EKgspftIXoVa7P5lBocTGQhke/d689YHkdRWpNClnP+ge2z3o9wbk1uVUW0nvdhhQuo/luJtBGJjqYYjkaeK+53InZ7yC7amqn6pXfqUep8XeI/uUgkpQy1HtnHCDhXmx98UsbJIA9StaFTTb7o2ZIDnbrm4DG1E5kaFd/OVB8H5vI0XaSqvlPrU9wUXYpLwIgOqoyDM0cZoaMzCIV/Cp8xfAUm57D5MBtI6XNjLAh1WzsDYcY39dXK6Sj842t09
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(86362001)(54906003)(5660300002)(7416002)(6916009)(26005)(316002)(186003)(2616005)(8936002)(38100700002)(91956017)(508600001)(2906002)(122000001)(66556008)(66476007)(66446008)(64756008)(66946007)(4326008)(76116006)(8676002)(53546011)(36756003)(6512007)(6506007)(33656002)(71200400001)(6486002)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?86mOiY8T08X0bE7x0Y8gz2ODD05osxtAOTg0UYhZiYllCthQwzvBWHTWlx5U?=
 =?us-ascii?Q?NysdMI6qUkuWH0MpQrtNJbcHhNhiSbgE1ixRfWcmeJuNBZsZ+g+VDVVEYB9K?=
 =?us-ascii?Q?IU9mvsApEHZiYI+ENiP1gijixguBYLY2IFDncHRQ7sOff2YDPDzOdE/wCsgI?=
 =?us-ascii?Q?C5DTv6Cn3ALGK/i3J7yiVhLF8U/8hea817UaL+psBq42mY7EZm+mhQjFsIB7?=
 =?us-ascii?Q?Smxxn4a6tQ93K0WJkSIcd91neEdbOsFCQfYuju0XJREJbUOLkMboDoYm00S8?=
 =?us-ascii?Q?iEe2lvtALt60OP6Ye69T1/o+GEArx5H3ozVJTmOwSOStD0FGbpihhXlQ8/cM?=
 =?us-ascii?Q?qk9BBf7OiVqFbo+lkaPM3lo6/JwZ+akDgPJUvijA0pXMjPS4d3u1L9XXXa57?=
 =?us-ascii?Q?ixw2NPkvh6J2ncHiNw32lc7XzlATdJVz8iBn3nJ2GBucK+g3WvmU5WlOpAp0?=
 =?us-ascii?Q?6H3mGzVqIO1XecAUR9tmZieUxkRIG2MulChUKn1/nRclvfA67J2oJMUaKdVR?=
 =?us-ascii?Q?dIeZY0O06P+y64r1Yh4wPydqsFXJmiTlpyonfgiWeV1you408tAdz2bkUb5e?=
 =?us-ascii?Q?R7KVYRa+naY8EkSSSuCioEyLTOtasutCRwOeYDowNTSXZC4MGOniEkcp8LOg?=
 =?us-ascii?Q?XnNX4eg69AaBcd6qNSXWEI9HanLO534pfnEhg/Vz8WorSXO9S4iz/KsetAp3?=
 =?us-ascii?Q?O0wuawEXJnM2QwvvX1Chv+khimNOkdoE94ZtXkNpNr33HJ2kwtIT16r2U7GN?=
 =?us-ascii?Q?it5vbcU/D091v9DTw8yg1H0UOkN7qZuGeIybQGzXWv18VsCthEYYwlQW1V5d?=
 =?us-ascii?Q?yj13EGhpYuJ1e9GXl6BbP8HneKiWmdN71t5gRU997OKoz1gZQUkhzCzNiSVn?=
 =?us-ascii?Q?UsCLeCrmNJFumjpZo4uODVgxM4kKbdpEH+c/nvWARh5iwqZEAwZQuw27e7NB?=
 =?us-ascii?Q?V5X5c/tkr1PfVEPRaSUfuZtB8X7WlDiR62qdWbaKwafIJoQYfBDmbtSSmPBn?=
 =?us-ascii?Q?n4gsAsaxiIP3cbK8KBtVnI9C+r/YGpZEPxHtVqFCCmTqgqm9qtMcvwfUEQaS?=
 =?us-ascii?Q?O9LRcNvCEamCAekFsj2bwVG4oT5RV+cjJ/IxA78WYdj1UbJDDjXG+DbrPMVB?=
 =?us-ascii?Q?NO2lZDcBRvmFXH51DCwE+XkNIv/Dkx5QtguDu6lx61zZu1KFDeBsXiDany7O?=
 =?us-ascii?Q?f0bf77G8e0vjRelfPsngbxg/qk8i4EloPw11oNEJbrPgIGxneO7ovrGn4t1Q?=
 =?us-ascii?Q?ihLm679K+yac7OZhqk29zRllOuTzqmtBZzN+2Rv/VyG1DFBE+37HOA+kjLI4?=
 =?us-ascii?Q?5GSvYmrbtP2LV29FF4Pz5qo0L5km+i0psNBUZ4D0Cv7xewEYifw7jodtPs2M?=
 =?us-ascii?Q?6j+wvMH61tTLMSBEXIuMoMH8NLwEHANBmd2FZYmGMhsVROpJwnJbx0EAnM5n?=
 =?us-ascii?Q?SEEkVwEHabD+NF1JswdSDe/BuWMbIU4OXIarLmMGzh6cHkuz77E96E9vaq+o?=
 =?us-ascii?Q?Esi1YHPncv+OPeE3YIkUst+M8tqWxriDeO0ZdOj9uyoSbVma3mYo57EDomq5?=
 =?us-ascii?Q?uALZ41YZyY7t/jK62kxJZ1nPH3PsIJlGoNnvPRA4wBVV+RDvjv01RZ6xFr+K?=
 =?us-ascii?Q?w9R1uIHd8ivwDqaJjgHevNOoNLDdkzlvzC6O5i6M+v4thJPuOfV5LDOvwxq3?=
 =?us-ascii?Q?rDaG6lKrz76LhLA0piX5dgohUbStVucO45ynUJE52VSMRWBsVs6sj2I3qfoV?=
 =?us-ascii?Q?fU494Jn+PQrfgjCfEzbywOLmvXeNBa4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DA9C68B841712B4081CEB2B4FD4DC926@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c567f16-7622-4867-5ff5-08da18cc3214
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2022 19:24:11.7844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vd+8pYtP2v++oHY8QF7tV7Z3cJphxJjVD6fMk0Obyk3tr4Wk0G7hFZBSYv7gp+16PJ1/GiRTKUOfEcupLMQs1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5228
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-07_01:2022-04-07,2022-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204070064
X-Proofpoint-ORIG-GUID: i-8NCrt8BQrrLZTyc7kddds_wwaxIUwx
X-Proofpoint-GUID: i-8NCrt8BQrrLZTyc7kddds_wwaxIUwx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Apr 6, 2022, at 8:18 PM, Hugh Dickins <hughd@google.com> wrote:
>=20
> On Wed, 6 Apr 2022, Chuck Lever III wrote:
>=20
>> Good day, Hugh-
>=20
> Huh! If you were really wishing me a good day, would you tell me this ;-?
>=20
>>=20
>> I noticed that several fsx-related tests in the xfstests suite are
>> failing after updating my NFS server to v5.18-rc1. I normally test
>> against xfs, ext4, btrfs, and tmpfs exports. tmpfs is the only export
>> that sees these new failures:
>>=20
>> generic/075 2s ... [failed, exit status 1]- output mismatch (see /home/c=
el/src/xfstests/results//generic/075.out.bad)
>>    --- tests/generic/075.out	2014-02-13 15:40:45.000000000 -0500
>>    +++ /home/cel/src/xfstests/results//generic/075.out.bad	2022-04-05 16=
:39:59.145991520 -0400
>>    @@ -4,15 +4,5 @@
>>     -----------------------------------------------
>>     fsx.0 : -d -N numops -S 0
>>     -----------------------------------------------
>>    -
>>    ------------------------------------------------
>>    -fsx.1 : -d -N numops -S 0 -x
>>    ------------------------------------------------
>>    ...
>>    (Run 'diff -u /home/cel/src/xfstests/tests/generic/075.out /home/cel/=
src/xfstests/results//generic/075.out.bad'  to see the entire diff)
>>=20
>> generic/091 9s ... [failed, exit status 1]- output mismatch (see /home/c=
el/src/xfstests/results//generic/091.out.bad)
>>    --- tests/generic/091.out	2014-02-13 15:40:45.000000000 -0500
>>    +++ /home/cel/src/xfstests/results//generic/091.out.bad	2022-04-05 16=
:41:24.329063277 -0400
>>    @@ -1,7 +1,75 @@
>>     QA output created by 091
>>     fsx -N 10000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
>>    -fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
>>    -fsx -N 10000 -o 32768 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
>>    -fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
>>    -fsx -N 10000 -o 32768 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
>>    -fsx -N 10000 -o 128000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -W
>>    ...
>>    (Run 'diff -u /home/cel/src/xfstests/tests/generic/091.out /home/cel/=
src/xfstests/results//generic/091.out.bad'  to see the entire diff)
>>=20
>> generic/112 2s ... [failed, exit status 1]- output mismatch (see /home/c=
el/src/xfstests/results//generic/112.out.bad)
>>    --- tests/generic/112.out	2014-02-13 15:40:45.000000000 -0500
>>    +++ /home/cel/src/xfstests/results//generic/112.out.bad	2022-04-05 16=
:41:38.511075170 -0400
>>    @@ -4,15 +4,4 @@
>>     -----------------------------------------------
>>     fsx.0 : -A -d -N numops -S 0
>>     -----------------------------------------------
>>    -
>>    ------------------------------------------------
>>    -fsx.1 : -A -d -N numops -S 0 -x
>>    ------------------------------------------------
>>    ...
>>    (Run 'diff -u /home/cel/src/xfstests/tests/generic/112.out /home/cel/=
src/xfstests/results//generic/112.out.bad'  to see the entire diff)
>>=20
>> generic/127 49s ... - output mismatch (see /home/cel/src/xfstests/result=
s//generic/127.out.bad)
>>    --- tests/generic/127.out	2016-08-28 12:16:20.000000000 -0400
>>    +++ /home/cel/src/xfstests/results//generic/127.out.bad	2022-04-05 16=
:42:07.655099652 -0400
>>    @@ -4,10 +4,198 @@
>>     =3D=3D=3D FSX Light Mode, Memory Mapping =3D=3D=3D
>>     All 100000 operations completed A-OK!
>>     =3D=3D=3D FSX Standard Mode, No Memory Mapping =3D=3D=3D
>>    -All 100000 operations completed A-OK!
>>    +ltp/fsx -q -l 262144 -o 65536 -S 191110531 -N 100000 -R -W fsx_std_n=
ommap
>>    +READ BAD DATA: offset =3D 0x9cb7, size =3D 0xfae3, fname =3D /tmp/mn=
t/manet.ib-2323703/fsx_std_nommap
>>    +OFFSET	GOOD	BAD	RANGE
>>    ...
>>    (Run 'diff -u /home/cel/src/xfstests/tests/generic/127.out /home/cel/=
src/xfstests/results//generic/127.out.bad'  to see the entire diff)
>>=20
>> I bisected the problem to:
>>=20
>>  56a8c8eb1eaf ("tmpfs: do not allocate pages on read")
>>=20
>> generic/075 fails almost immediately without any NFS-level errors.
>> Likely this is data corruption rather than an overt I/O error.
>=20
> That's sad.  Thanks for bisecting and reporting.  Sorry for the nuisance.
>=20
> I suspect this patch is heading for a revert, because I shall not have
> time to debug and investigate.  Cc'ing fsdevel and a few people who have
> an interest in it, to warn of that likely upcoming revert.
>=20
> But if it's okay with everyone, please may we leave it in for -rc2?
> Given that having it in -rc1 already smoked out another issue (problem
> of SetPageUptodate(ZERO_PAGE(0)) without CONFIG_MMU), I think keeping
> it in a little longer might smoke out even more.
>=20
> The xfstests info above doesn't actually tell very much, beyond that
> generic/075 generic/091 generic/112 generic/127, each a test with fsx,
> all fall at their first hurdle.  If you have time, please rerun and
> tar up the results/generic directory (maybe filter just those failing)
> and send as attachment.  But don't go to any trouble, it's unlikely
> that I shall even untar it - it would be mainly to go on record if
> anyone has time to look into it later.  And, frankly, it's unlikely
> to tell us anything more enlightening, than that the data seen was
> not as expected: which we do already know.
>=20
> I've had no problem with xfstests generic 075,091,112,127 testing
> tmpfs here, not before and not in the month or two I've had that
> patch in: so it's something in the way that NFS exercises tmpfs
> that reveals it.  If I had time to duplicate your procedure, I'd be
> asking for detailed instructions: but no, I won't have a chance.
>=20
> But I can sit here and try to guess.  I notice fs/nfsd checks
> file->f_op->splice_read, and employs fallback if not available:
> if you have time, please try rerunning those xfstests on an -rc1
> kernel, but with mm/shmem.c's .splice_read line commented out.
> My guess is that will then pass the tests, and we shall know more.

This seemed like the most probative next step, so I commented
out the .splice_read call-out in mm/shmem.c and ran the tests
again. Yes, that change enables the fsx-related tests to pass
as expected.


> What could be going wrong there?  I've thought of two possibilities.
> A minor, hopefully easily fixed, issue would be if fs/nfsd has
> trouble with seeing the same page twice in a row: since tmpfs is
> now using the ZERO_PAGE(0) for all pages of a hole, and I think I
> caught sight of code which looks to see if the latest page is the
> same as the one before.  It's easy to imagine that might go wrong.

Are you referring to this function in fs/nfsd/vfs.c ?

 847 static int
 848 nfsd_splice_actor(struct pipe_inode_info *pipe, struct pipe_buffer *bu=
f,
 849                   struct splice_desc *sd)
 850 {
 851         struct svc_rqst *rqstp =3D sd->u.data;
 852         struct page **pp =3D rqstp->rq_next_page;
 853         struct page *page =3D buf->page;
 854=20
 855         if (rqstp->rq_res.page_len =3D=3D 0) {
 856                 svc_rqst_replace_page(rqstp, page);
 857                 rqstp->rq_res.page_base =3D buf->offset;
 858         } else if (page !=3D pp[-1]) {
 859                 svc_rqst_replace_page(rqstp, page);
 860         }
 861         rqstp->rq_res.page_len +=3D sd->len;
 862=20
 863         return sd->len;
 864 }

rq_next_page should point to the first unused element of
rqstp->rq_pages, so IIUC that check is looking for the
final page that is part of the READ payload.

But that does suggest that if page -> ZERO_PAGE and so does
pp[-1], then svc_rqst_replace_page() would not be invoked.


> A more difficult issue would be, if fsx is racing writes and reads,
> in a way that it can guarantee the correct result, but that correct
> result is no longer delivered: because the writes go into freshly
> allocated tmpfs cache pages, while reads are still delivering
> stale ZERO_PAGEs from the pipe.  I'm hazy on the guarantees there.
>=20
> But unless someone has time to help out, we're heading for a revert.
>=20
> Thanks,
> Hugh

--
Chuck Lever



