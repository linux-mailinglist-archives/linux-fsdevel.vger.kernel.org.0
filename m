Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB7672E7D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 18:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240492AbjFMQF0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 12:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243020AbjFMQFT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:05:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126BE1996
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jun 2023 09:05:16 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35DFx8At018312;
        Tue, 13 Jun 2023 16:05:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=hWyCJzgo/+87JabuhavIs6HsnKX9isXygWdfofKlyUc=;
 b=WcPOn9Heg/jsoXWbfd9lBMhWVKRfCf1YS+JoO8pDIxca9/52auAC7bujKWpa3HXZDNEe
 6qQiN+OoBR7uk/RwdGirak7ax+NTYhJjIb0HB/g0o1B7kxM4kjNXSGEB3fFykaG/HXOk
 vCeWe2//aWBGSPwteR3NC7yV4Lyq+mK8muxexmfPr1WM+3JtKg41gUVZaRd5b6mn+0KR
 nafQW4jfhCd5gtMjaJZi/yExMFZ8BepNd4ZijvIHb9iDqN3IOBTk6AiQMaIDefbwTl62
 rxo9bjqz72sBP6Do1psSehBF2MNRHo14BoFpdaNB7tZFGd5Hvtmz0/v/8O7TiSSnSa+0 mw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fy3dmsd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jun 2023 16:05:04 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35DFumbn008940;
        Tue, 13 Jun 2023 16:05:04 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm4msh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jun 2023 16:05:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzhHohRFNJwHubRPioMM/cbdKkCOs2Zp/cadPt/B3a3gYWphiQiMAoLLVrfP+U8yA2+sPM5Mnn8Z5/gGtulE2fI8ZT5mECB/GQbbCE/1CxbpkgF3q6w1+ij8ZF4QxLgOyWjT6vrlWfJ20aHMFmPeZkf99I5rVI0xykW6uDMtliWqPesJiSewkWjz+t5m1uAQ9ZROG9Q4ab43hs39wLCzwDk/5Mdyz6785G+J2qHXhTHzsBeaLdsnwqbwdBugKsKb+T0UeV5A52rRrPa2XQYmUXbyusbKwC0iZwqw/uXLFP4jrK1QkUsQUP3OrpaHLssUq+VUn+UBiVXAyC3mzS8LFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWyCJzgo/+87JabuhavIs6HsnKX9isXygWdfofKlyUc=;
 b=Tu7cOgJKx4WomCjJdNlRXqdo168Z/+mqkjOC0aE28JSbJrqLifXpzaTXhGkvp2STg6+Z/BsCzMvcus+HxCs8tXTE8Y4+l5Gz2JmQxY90MPQMhb3nGy9SmjitP9mZOXS/6d08U4RTSIh7xb+vrECSpYSL5dJbrPhGTbry8050W3LrspyWkKCoYHleeNR95kaB1pLLc0mKBEE+sLi5rSsxTffjg9/vdngM1+03Z4iO6B+g3cmtOPCQL+SMaXgVkHvvFc34807i8eUWKk+4wLbPKbUgJs6Vo0bAubXpjAWI6RGQfRdzSKGpsLGKOtCfgO/AYN7Vi2bgN14uM6zphlYDHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWyCJzgo/+87JabuhavIs6HsnKX9isXygWdfofKlyUc=;
 b=kkmU5o6Hk+kQFiqEKw0ZbLM2712FQtqUcoIm2aNomHES4IFnAPA0H+AweVNIoWliy8aKl1xute0q8nL3iMu/Gu8c44bHHONPcvr1fIJSFG7xqsOFGsl4nRQG8JySdzlLNoXuNhxCegCE66IV8g/A3tf8e/ZUWvKj2uuaAspx52Y=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by CH0PR10MB5097.namprd10.prod.outlook.com (2603:10b6:610:c2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 16:05:00 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::d634:f050:9501:46dd]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::d634:f050:9501:46dd%3]) with mapi id 15.20.6455.043; Tue, 13 Jun 2023
 16:05:00 +0000
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
To:     Damien Le Moal <dlemoal@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] zonefs: use iomap for synchronous direct writes
Thread-Topic: [PATCH v2] zonefs: use iomap for synchronous direct writes
Thread-Index: AQHZlIiNPFbWeoZl+kCuCai492TdWa+I+IQA
Date:   Tue, 13 Jun 2023 16:05:00 +0000
Message-ID: <1C262807-BC8A-4D5F-A99D-7EE88C50B590@oracle.com>
References: <20230601125636.205191-1-dlemoal@kernel.org>
In-Reply-To: <20230601125636.205191-1-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB2943:EE_|CH0PR10MB5097:EE_
x-ms-office365-filtering-correlation-id: 5b27f02b-3886-42a3-6bea-08db6c27f11a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hGm//zQhKWIBbK9m95WjKilbIes88yBwW0QCdNsiGw5YJo0M1bR310U+f68OyHYoOh+0DwnEuPIR27C6CWe9jxGxl1BHQXMqzwlLAWDP2nmvb23zpV0Hx63+MPEK97gRLnZONtMF4yV2q4U4EkaIY/PY562hh95q2E9FWb1U3szt6MbtLWlpTiJi/4Fidr3/tMqRXhEMA/Ol/jCqydx4aqmqr6g/aSz//F3tx+AzB0YHDRc0ijF7j173tSBfVICtjsYXM/s++tG7bcBijJrg6Lt2xH1rI4NQo3K1FnhmeaWlMoSFh/8705np7wlcSZysaBicbeetqFzjTG8Grr9EJ4gzosCJCajqlwU3kajwZkog5IQyCmz4BJN2HzaRckIB/uBkh1WTXaTndHu53s/xS9cquFeeXusu47GNtR2lWu1Qoj6uR4X25RuipAfIc3TUQA9P4Q/tVY/XXaMQadeRAup3sA4ywW4jJ8hQ7X4hWD6XSFUuNkLKNn39xT5FCtr4CuSdDGMCM5c6e+d47uIDlOAWE1WfsZbRx3R7a70V0GcAj/qbagY4BDWcrz5Cg131kzsfDgXixDVuOwA/oY6MnHheUOuLrTvQ3HaXuV9VBGgaOIVdvBqG1uxRkI06rAX920l1/Nln90GAF3JcC7YfDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199021)(6916009)(66946007)(76116006)(4326008)(91956017)(66446008)(66556008)(64756008)(36756003)(186003)(54906003)(478600001)(2616005)(30864003)(2906002)(66476007)(8676002)(316002)(41300700001)(86362001)(6486002)(6506007)(33656002)(53546011)(38070700005)(122000001)(71200400001)(8936002)(44832011)(83380400001)(26005)(5660300002)(38100700002)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9Iimlkdnq4fd5KkSXXOQO9iWdQMD1eugRsGkBztGaNAtls2lCYTDYIAX5d94?=
 =?us-ascii?Q?ME15n/ZsFEu2Y8wjZTQogZw3o2EJqP4aGGkE5C4NIVTateJZpy6AQP2EJQsJ?=
 =?us-ascii?Q?/e2lKzh2SKmrwnRFbGa+gRVRU9KpFMIR+SLymGD/ySImpTb9//9lMlPSo2jP?=
 =?us-ascii?Q?5sT0UFLxJKYfAaov/wXnRAU7PYAdvZvobUWTN2jkhEf7pjfv7LqwCaSDed3e?=
 =?us-ascii?Q?9FBsbu3BnxczMCQSrpz4zuH6Hv8spVd33Y4waaGawj4/wNWnIDggRDqRQ0CY?=
 =?us-ascii?Q?98znSuAx3sFr3gjdHrrDs6stjh98LefERwgYHQtP78MutYxAcGCCmXrY+TLP?=
 =?us-ascii?Q?pLQTuCnbQXCJL/1E+6IhmXW4cZ08jKPv4sAdSqsrLXo5s7sdFkeb0ZxcZMWq?=
 =?us-ascii?Q?FqPJCrw1CX0tZYypr7s6oA4ucrgrFeuooeqqKHlkSY9Qajt/g8pBgLSqcdWs?=
 =?us-ascii?Q?YcZq9tpfUiJUn64ZflV2Q6/r0+62VodLdlxyB2LRHCt8GcQFtmIGius7V+xV?=
 =?us-ascii?Q?dCry0pJ41U7PSBMIMXktHhThQZo7TtLF4/BRfIcffPVGMdj2cg4wONQfrXsb?=
 =?us-ascii?Q?5S0rSgibWenouNy6TEWM5DvPo6oQgXpGc1UxzOn08eZbv/8e7BcdbMfUW8S6?=
 =?us-ascii?Q?3QTRNdW8YjkubdGhRM6XR9GXYiOx3yivU1Yl9eizmqiIAQapa/Gh7GZwnOYH?=
 =?us-ascii?Q?kzfrpUQW5f/MCpb1AHq7b5Ce45u3zl+pPoAvYw2+3mnt85U/kCX69fhvB13N?=
 =?us-ascii?Q?KiKYHX7NvVpf4bXGPZlIycAhyYf3tktekfDKlfJnYoYLMhGbt22a918Om6qb?=
 =?us-ascii?Q?m2yUm5go88qMcil0zRderqVOCAzQ15M14CdP45cQTa80pzx2Cr6oQxdRl+UB?=
 =?us-ascii?Q?vZ53W2xPeVmfcAGJIdMvXgGjJaAdYsUYjc6VZNTTazlUOy/XO3hMHeatJkC0?=
 =?us-ascii?Q?RvxtXzbJRXINIz7Kxd7RBW2gJv+T8yRz3ITsPCJD8X+QKjNXZFz5zU6cAL1Y?=
 =?us-ascii?Q?RYjV4Wjlg0Ef8W3b71v978nfkHwd4VjTOeV/aSiYp++iyhcyjnL6UBz71ba+?=
 =?us-ascii?Q?M2nxuOfRmbYGqaUuO9LCrUYkTkGLroq8Cyi7CYYASNJ+4PU9HoKxGDWrjUJH?=
 =?us-ascii?Q?oaNMFisxCcCQxX9gu/32jat4ouBSmMg1rRUiS3IvXRMKzDYrxI1XrUFNDtXy?=
 =?us-ascii?Q?IvmnnGPaF55oyoTf7Y1mbhbpFEQSECqLUPzY0lo35Gmb/D5PmcgFhXrb5CBK?=
 =?us-ascii?Q?+fQtbmN2nYJsyQ/N9Opv1amQAqqdHAtJ2TyIiI5TUguw7S87nfRUwhYoAGJw?=
 =?us-ascii?Q?zmYBaxPucARX7otQ6dK7lJWl/fu426kEY8DcdIzLRgIKgnlxaQB4o1DpBJ0m?=
 =?us-ascii?Q?HBzW1w6VhphzVHGfFM1l3QGRAbXSWbkujW4tKa0h9ro9El+Gt16a6pWMt8YO?=
 =?us-ascii?Q?lsPFeaCbp8QHiyqiLK0OtFdljMGvA63dEQGXgdHbvoKlITfe6y3y9QYQ47+S?=
 =?us-ascii?Q?oxBMsuiBiwfn4WkdOV9GOD4iy78wmyNqtqy6rIX9iwlFowZAQLezaak0adMH?=
 =?us-ascii?Q?aM5sqxp7K8c5Zktazj10LlcpDcvtN0B2UOcrFm0sX/6J3EYbiBzgSRc0cc7k?=
 =?us-ascii?Q?XA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <131ABAB873492C4784C9AA8DD1DFD042@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: F9HaIcQu2LZSLrElhj/PZ/ILT3TvUliNEtAqEEe36uN/DwIT2BdmpRVAXdpYz+55LO4gIN5vqA/I6QaUqIDG8oAnM3vMVXFpooB/db9OVTdN4N/LlZhlWoJET07qCD4SuP0mzHDIjhy9AnBmPpECsCJiK/i0gVn/NRZOwgHGFcX0fDDZ1MbN5g1eBJTPY2KPX0XFdqrHXl7sNhjsPBRNziv7WMgCRAyTecfn3HueFOYNyXb2n5GRm1t6G0jodU8RszvKREeQjOvNY1zFUVA5hs51Nc1DMDR81V28QYFEjTcGnnmMJ5OdZbw2osOAZV0CqEPQ53nDHpLrX4qKxND0rHxILigzf/yHHepyg7gI4YezKAFFVKA2/2wmgBSPXlOMHxYZ8AzZ3pdDCPABgdhHeCN9ggZ+Kpxn9v4hjTTivjlptWqSnMogtvbcBay8MAnNfk93yIVdOQ1avlD1SF4u3GQjqQ/jhCdOUBmE/ln8lNmtb4KiAOfsI00DsdOkb94R50jq3ZYBSeOcMP+Q41dQCGWd7GT2xHwLLXAasNKnQka/DX2Rf/3oHX+CBweK46wMuwiggcYH5NTAUU5snGze3wNGacq5aXcpA7F0PvR27n/L2+ppUC8h2tOBNd/nXxvTnNvXeIp92xh+Qyh1cEKybUwFv4Sn27DuUSImLDrf6Wy62hsryZn2APZRZOAHUZ4WnoTa8ldKnwEgVD2tsYNqltGVXAzGZSUGgu9KlJleCQEMoO339sU44cxJ9YrBeI4TJSw1t0Iw4q0tFzxMXFc6hoqQvMLOgRc5wEAMc3N61nKXFE0X7NRSysXRc7/eGXOxVXdhB/ecbHpdBKoVKQCBOw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b27f02b-3886-42a3-6bea-08db6c27f11a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 16:05:00.7549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V+9PAvKHJcynEukL+9uHmxIp5FC5RB3tJuiu8KB7wmuJ+gqu7g807tSDu0Wu+E55lJPZVmxnNd5Yp3U6qGUMwcOR0MzarFtL/wuwD0LFd7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5097
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_18,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306130142
X-Proofpoint-GUID: RKu20RdYRcDpl4GaGG-PI0eUUcrrmt6x
X-Proofpoint-ORIG-GUID: RKu20RdYRcDpl4GaGG-PI0eUUcrrmt6x
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jun 1, 2023, at 5:56 AM, Damien Le Moal <dlemoal@kernel.org> wrote:
>=20
> Remove the function zonefs_file_dio_append() that is used to manually
> issue REQ_OP_ZONE_APPEND BIOs for processing synchronous direct writes
> and use iomap instead.
>=20
> To preserve the use of zone append operations for synchronous writes,
> different struct iomap_dio_ops are defined. For synchronous direct
> writes using zone append, zonefs_zone_append_dio_ops is introduced.
> The submit_bio operation of this structure is defined as the function
> zonefs_file_zone_append_dio_submit_io() which is used to change the BIO
> opreation for synchronous direct IO writes to REQ_OP_ZONE_APPEND.
>=20
> In order to preserve the write location check on completion of zone
> append BIOs, the end_io operation is also defined using the function
> zonefs_file_zone_append_dio_bio_end_io(). This check now relies on the
> zonefs_zone_append_bio structure, allocated together with zone append
> BIOs with a dedicated BIO set. This structure include the target inode
> of a zone append BIO as well as the target append offset location for
> the zone append operation. This is used to perform a check against
> bio->bi_iter.bi_sector when the BIO completes, without needing to use
> the zone information z_wpoffset field, thus removing the need for
> taking the inode truncate mutex.
>=20
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>=20
> Changes from v1:
> * Renamed a few things (iomap operations, zonefs bio set, ...)
> * Restrict the use of the bio set to zone append synchronous writes
>=20
> fs/zonefs/file.c   | 206 ++++++++++++++++++++++++---------------------
> fs/zonefs/super.c  |   9 +-
> fs/zonefs/zonefs.h |   2 +
> 3 files changed, 120 insertions(+), 97 deletions(-)
>=20
> diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
> index 132f01d3461f..c34ec5b54053 100644
> --- a/fs/zonefs/file.c
> +++ b/fs/zonefs/file.c
> @@ -342,6 +342,77 @@ static loff_t zonefs_file_llseek(struct file *file, =
loff_t offset, int whence)
> return generic_file_llseek_size(file, offset, whence, isize, isize);
> }
>=20
> +struct zonefs_zone_append_bio {
> + /* The target inode of the BIO */
> + struct inode *inode;
> +
> + /* For sync writes, the target append write offset */
> + u64 append_offset;
> +
> + /*
> + * This member must come last, bio_alloc_bioset will allocate enough
> + * bytes for entire zonefs_bio but relies on bio being last.
> + */
> + struct bio bio;
> +};
> +
> +static inline struct zonefs_zone_append_bio *
> +zonefs_zone_append_bio(struct bio *bio)
> +{
> + return container_of(bio, struct zonefs_zone_append_bio, bio);
> +}
> +
> +static void zonefs_file_zone_append_dio_bio_end_io(struct bio *bio)
> +{
> + struct zonefs_zone_append_bio *za_bio =3D zonefs_zone_append_bio(bio);
> + struct zonefs_zone *z =3D zonefs_inode_zone(za_bio->inode);
> + sector_t za_sector;
> +
> + if (bio->bi_status !=3D BLK_STS_OK)
> + goto bio_end;
> +
> + /*
> + * If the file zone was written underneath the file system, the zone
> + * append operation can still succedd (if the zone is not full) but
> + * the write append location will not be where we expect it to be.
> + * Check that we wrote where we intended to, that is, at z->z_wpoffset.
> + */
> + za_sector =3D z->z_sector + (za_bio->append_offset >> SECTOR_SHIFT);
> + if (bio->bi_iter.bi_sector !=3D za_sector) {
> + zonefs_warn(za_bio->inode->i_sb,
> +    "Invalid write sector %llu for zone at %llu\n",
> +    bio->bi_iter.bi_sector, z->z_sector);
> + bio->bi_status =3D BLK_STS_IOERR;
> + }
> +
> +bio_end:
> + iomap_dio_bio_end_io(bio);
> +}
> +
> +static void zonefs_file_zone_append_dio_submit_io(const struct iomap_ite=
r *iter,
> +  struct bio *bio,
> +  loff_t file_offset)
> +{
> + struct zonefs_zone_append_bio *za_bio =3D zonefs_zone_append_bio(bio);
> + struct inode *inode =3D iter->inode;
> + struct zonefs_zone *z =3D zonefs_inode_zone(inode);
> +
> + /*
> + * Issue a zone append BIO to process sync dio writes. The append
> + * file offset is saved to check the zone append write location
> + * on completion of the BIO.
> + */
> + za_bio->inode =3D inode;
> + za_bio->append_offset =3D file_offset;
> +
> + bio->bi_opf &=3D ~REQ_OP_WRITE;
> + bio->bi_opf |=3D REQ_OP_ZONE_APPEND;
> + bio->bi_iter.bi_sector =3D z->z_sector;
> + bio->bi_end_io =3D zonefs_file_zone_append_dio_bio_end_io;
> +
> + submit_bio(bio);
> +}
> +
> static int zonefs_file_write_dio_end_io(struct kiocb *iocb, ssize_t size,
> int error, unsigned int flags)
> {
> @@ -372,93 +443,17 @@ static int zonefs_file_write_dio_end_io(struct kioc=
b *iocb, ssize_t size,
> return 0;
> }
>=20
> -static const struct iomap_dio_ops zonefs_write_dio_ops =3D {
> - .end_io =3D zonefs_file_write_dio_end_io,
> -};
> +static struct bio_set zonefs_zone_append_bio_set;
>=20
> -static ssize_t zonefs_file_dio_append(struct kiocb *iocb, struct iov_ite=
r *from)
> -{
> - struct inode *inode =3D file_inode(iocb->ki_filp);
> - struct zonefs_zone *z =3D zonefs_inode_zone(inode);
> - struct block_device *bdev =3D inode->i_sb->s_bdev;
> - unsigned int max =3D bdev_max_zone_append_sectors(bdev);
> - pgoff_t start, end;
> - struct bio *bio;
> - ssize_t size =3D 0;
> - int nr_pages;
> - ssize_t ret;
> -
> - max =3D ALIGN_DOWN(max << SECTOR_SHIFT, inode->i_sb->s_blocksize);
> - iov_iter_truncate(from, max);
> -
> - /*
> - * If the inode block size (zone write granularity) is smaller than the
> - * page size, we may be appending data belonging to the last page of the
> - * inode straddling inode->i_size, with that page already cached due to
> - * a buffered read or readahead. So make sure to invalidate that page.
> - * This will always be a no-op for the case where the block size is
> - * equal to the page size.
> - */
> - start =3D iocb->ki_pos >> PAGE_SHIFT;
> - end =3D (iocb->ki_pos + iov_iter_count(from) - 1) >> PAGE_SHIFT;
> - if (invalidate_inode_pages2_range(inode->i_mapping, start, end))
> - return -EBUSY;
> -
> - nr_pages =3D iov_iter_npages(from, BIO_MAX_VECS);
> - if (!nr_pages)
> - return 0;
> -
> - bio =3D bio_alloc(bdev, nr_pages,
> - REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE, GFP_NOFS);
> - bio->bi_iter.bi_sector =3D z->z_sector;
> - bio->bi_ioprio =3D iocb->ki_ioprio;
> - if (iocb_is_dsync(iocb))
> - bio->bi_opf |=3D REQ_FUA;
> -
> - ret =3D bio_iov_iter_get_pages(bio, from);
> - if (unlikely(ret))
> - goto out_release;
> -
> - size =3D bio->bi_iter.bi_size;
> - task_io_account_write(size);
> -
> - if (iocb->ki_flags & IOCB_HIPRI)
> - bio_set_polled(bio, iocb);
> -
> - ret =3D submit_bio_wait(bio);
> -
> - /*
> - * If the file zone was written underneath the file system, the zone
> - * write pointer may not be where we expect it to be, but the zone
> - * append write can still succeed. So check manually that we wrote where
> - * we intended to, that is, at zi->i_wpoffset.
> - */
> - if (!ret) {
> - sector_t wpsector =3D
> - z->z_sector + (z->z_wpoffset >> SECTOR_SHIFT);
> -
> - if (bio->bi_iter.bi_sector !=3D wpsector) {
> - zonefs_warn(inode->i_sb,
> - "Corrupted write pointer %llu for zone at %llu\n",
> - bio->bi_iter.bi_sector, z->z_sector);
> - ret =3D -EIO;
> - }
> - }
> -
> - zonefs_file_write_dio_end_io(iocb, size, ret, 0);
> - trace_zonefs_file_dio_append(inode, size, ret);
> -
> -out_release:
> - bio_release_pages(bio, false);
> - bio_put(bio);
> -
> - if (ret >=3D 0) {
> - iocb->ki_pos +=3D size;
> - return size;
> - }
> +static const struct iomap_dio_ops zonefs_zone_append_dio_ops =3D {
> + .submit_io =3D zonefs_file_zone_append_dio_submit_io,
> + .end_io =3D zonefs_file_write_dio_end_io,
> + .bio_set =3D &zonefs_zone_append_bio_set,
> +};
>=20
> - return ret;
> -}
> +static const struct iomap_dio_ops zonefs_write_dio_ops =3D {
> + .end_io =3D zonefs_file_write_dio_end_io,
> +};
>=20
> /*
>  * Do not exceed the LFS limits nor the file zone size. If pos is under t=
he
> @@ -539,6 +534,7 @@ static ssize_t zonefs_file_dio_write(struct kiocb *io=
cb, struct iov_iter *from)
> struct zonefs_inode_info *zi =3D ZONEFS_I(inode);
> struct zonefs_zone *z =3D zonefs_inode_zone(inode);
> struct super_block *sb =3D inode->i_sb;
> + const struct iomap_dio_ops *dio_ops;
> bool sync =3D is_sync_kiocb(iocb);
> bool append =3D false;
> ssize_t ret, count;
> @@ -582,20 +578,26 @@ static ssize_t zonefs_file_dio_write(struct kiocb *=
iocb, struct iov_iter *from)
> }
>=20
> if (append) {
> - ret =3D zonefs_file_dio_append(iocb, from);
> + unsigned int max =3D bdev_max_zone_append_sectors(sb->s_bdev);
> +
> + max =3D ALIGN_DOWN(max << SECTOR_SHIFT, sb->s_blocksize);
> + iov_iter_truncate(from, max);
> +
> + dio_ops =3D &zonefs_zone_append_dio_ops;
> } else {
> - /*
> - * iomap_dio_rw() may return ENOTBLK if there was an issue with
> - * page invalidation. Overwrite that error code with EBUSY to
> - * be consistent with zonefs_file_dio_append() return value for
> - * similar issues.
> - */
> - ret =3D iomap_dio_rw(iocb, from, &zonefs_write_iomap_ops,
> -   &zonefs_write_dio_ops, 0, NULL, 0);
> - if (ret =3D=3D -ENOTBLK)
> - ret =3D -EBUSY;
> + dio_ops =3D &zonefs_write_dio_ops;
> }
>=20
> + /*
> + * iomap_dio_rw() may return ENOTBLK if there was an issue with
> + * page invalidation. Overwrite that error code with EBUSY so that
> + * the user can make sense of the error.
> + */
> + ret =3D iomap_dio_rw(iocb, from, &zonefs_write_iomap_ops,
> +   dio_ops, 0, NULL, 0);
> + if (ret =3D=3D -ENOTBLK)
> + ret =3D -EBUSY;
> +
> if (zonefs_zone_is_seq(z) &&
>    (ret > 0 || ret =3D=3D -EIOCBQUEUED)) {
> if (ret > 0)
> @@ -900,3 +902,15 @@ const struct file_operations zonefs_file_operations =
=3D {
> .splice_write =3D iter_file_splice_write,
> .iopoll =3D iocb_bio_iopoll,
> };
> +
> +int zonefs_file_bioset_init(void)
> +{
> + return bioset_init(&zonefs_zone_append_bio_set, BIO_POOL_SIZE,
> +   offsetof(struct zonefs_zone_append_bio, bio),
> +   BIOSET_NEED_BVECS);
> +}
> +
> +void zonefs_file_bioset_exit(void)
> +{
> + bioset_exit(&zonefs_zone_append_bio_set);
> +}
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index 23b8b299c64e..56c00111966a 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -1412,10 +1412,14 @@ static int __init zonefs_init(void)
>=20
> BUILD_BUG_ON(sizeof(struct zonefs_super) !=3D ZONEFS_SUPER_SIZE);
>=20
> - ret =3D zonefs_init_inodecache();
> + ret =3D zonefs_file_bioset_init();
> if (ret)
> return ret;
>=20
> + ret =3D zonefs_init_inodecache();
> + if (ret)
> + goto destroy_bioset;
> +
> ret =3D zonefs_sysfs_init();
> if (ret)
> goto destroy_inodecache;
> @@ -1430,6 +1434,8 @@ static int __init zonefs_init(void)
> zonefs_sysfs_exit();
> destroy_inodecache:
> zonefs_destroy_inodecache();
> +destroy_bioset:
> + zonefs_file_bioset_exit();
>=20
> return ret;
> }
> @@ -1439,6 +1445,7 @@ static void __exit zonefs_exit(void)
> unregister_filesystem(&zonefs_type);
> zonefs_sysfs_exit();
> zonefs_destroy_inodecache();
> + zonefs_file_bioset_exit();
> }
>=20
> MODULE_AUTHOR("Damien Le Moal");
> diff --git a/fs/zonefs/zonefs.h b/fs/zonefs/zonefs.h
> index 8175652241b5..f663b8ebc2cb 100644
> --- a/fs/zonefs/zonefs.h
> +++ b/fs/zonefs/zonefs.h
> @@ -279,6 +279,8 @@ extern const struct file_operations zonefs_dir_operat=
ions;
> extern const struct address_space_operations zonefs_file_aops;
> extern const struct file_operations zonefs_file_operations;
> int zonefs_file_truncate(struct inode *inode, loff_t isize);
> +int zonefs_file_bioset_init(void);
> +void zonefs_file_bioset_exit(void);
>=20
> /* In sysfs.c */
> int zonefs_sysfs_register(struct super_block *sb);
> --=20
> 2.40.1
>=20

Looks Good.

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--=20
Himanshu Madhani Oracle Linux Engineering

