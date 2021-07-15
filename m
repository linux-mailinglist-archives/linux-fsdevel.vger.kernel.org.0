Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37CDA3CA1B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 17:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239525AbhGOP6b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 11:58:31 -0400
Received: from mail-dm6nam10on2040.outbound.protection.outlook.com ([40.107.93.40]:45335
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239474AbhGOP6a (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 11:58:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjOwFNYqVvU+WaU+r+r625kJYl8H4n9DFlAnrm/0xb8k/PZCd7zbNEth2RwjrcdvyuxOMzKX7J9f8jBmR3JU22Sx8tcuMU4cHrYJ6g2pECM9L5tkDdEOg9Wksd/ck9X9M9MaqS7hrqfzC9KWtZDlwdA3g++R3tl7QPs7ikpQ3ThNVTJnonOHVFv5BfoOkMJf9XkXATzdbJB2MaNFL7IkYE2Ta+q/gTpiJfyIo7b4Ucd9UGfFHa8Jo1Ghm9Ce6RPjIITh2oIQaeNc46KBZNK+0hu2fBRnIHNq76MGPb9H09iCWN3C4Dhs8SlpcSRLBQzQewIEc2xhaHJ7PzbQQj4KAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXrNFPmEDqMFypG1wrcBzOMjNI3P+UO5pHr2z7Monqo=;
 b=nwEXgAvJEabeF7pv+eCaCxzefcm1an6XVsOuHe0z/r31XBOiHeSgx6ImBUKelNr7ftk00B2M71vM1Uw/YhnI4VRKz88ycH2UH45gPwpAKmfdD0KrfP6IXbbgB2GBMu0tOElwmU34thOVFth1EM760YczyOUy7eTdVAamE+2DIBF8n9Q3g5VFaz9MV91GwYIZZNK7L3KolymxySdnUEs4Nt3ycQy9h3lhny4zlKT7Vct+4wU9AXkdXUHvKdAndOeJ4lOvcCN8T9wq31ppSCpAbGfcO/NPxWkUsB2fZ7EpSq8NAR8LJd0+zGgldh8i395t9/tAQXinWYahyR14KTHp9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXrNFPmEDqMFypG1wrcBzOMjNI3P+UO5pHr2z7Monqo=;
 b=b8o5wip+h/GeXwMhAixOq3BxVWc5kzgk4V9b3KBlaS7C7x4OwkU5ee3oS7dB5l9QVmLWgvE3oOAVVKie7U5Tr/L2PQhoLx6j2xLXf74f934lawdE7nmG5cN/2wpfthue9R0y4LpEfO+deIeqQRCholZ1QforAK9enBd/TG72SE7Nhz6mEFfmhr+eCUjHjYNO705HkmwhfpHL1q8rBws5N8MYp38dQRnwM1swgsB94aEgL+9McQBhYxbSVbrDsfLrnJB5O7tg5e8Pfka5oiSn3kM0t1PawgQ2c6vlV7qoVbytO7UieDoJE63w52kTvVJc+ly98XEoT01xZ/TAQdlsmA==
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 15:55:36 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4%6]) with mapi id 15.20.4331.023; Thu, 15 Jul 2021
 15:55:36 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 061/138] mm/migrate: Add folio_migrate_flags()
Date:   Thu, 15 Jul 2021 11:55:30 -0400
X-Mailer: MailMate (1.14r5812)
Message-ID: <C1FDD422-A899-4111-B019-75B0A6D2979A@nvidia.com>
In-Reply-To: <20210715033704.692967-62-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-62-willy@infradead.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_553D7398-F86F-48E8-98BD-45F9BF183DF7_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAP220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::23) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [169.254.198.0] (216.228.112.22) by BLAP220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 15:55:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45f3d1ea-243f-4ace-961c-08d947a8fbfe
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB43734D290ABD4A471C9B9CE0C2129@MN2PR12MB4373.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yGpy8yca4qos7MMVlxj38qU5106og4ZTnyEKueeu45kOuW8NV7L7xfzM6wfE/65KvKk69qF9+AlR5Fxup1TsoQaRR5pD81kpZRwPfOG51hOloo1AL4rDGjhWjPIDYkNOcuPaTd6mDNH6JyA/qWgJknwOWExIW0vd+XSRnmNZKb/6av2PZLwDCJXyCodY8f3RYILsRDs46XDzNdVs0xLFcaYXJKQJsElJd7J7SoW4K4JxPzQwPG4bAtYpXSd+r/7liquZFrvzJkVAVErHNMppBOfMcHN5iWjC3u4wb7SEMxlgSvjKGPWKeRqbJ6ArCNKFQIy8q7vz/e2bs37bzRjTY+nLEAia1Zm1/hWsji8OBQqVjHtOyPdogupdGCIzyeUlcqvxFtg55qC5TbeT5HqAZ1+FFTqVNOZ+HVB2123SeuLQbW2FnNEQn2KGMsg8t612OQ/0RCwEY1F6hVb32jxkaT7Nsd9es5eZGwkw8OU5sfVHliI8bV3fFvkjN49lvMwSac447ULbfE5ZbKhXJdmk8rph8CC7EXK9ZG8kgSlDxmFUTlRYDLht9fH/CnvCBwL6stzqeIDvE0fYiFCakTF7XZgEtCRg0374fjssiuLCk5DxW7GR51Amt/rThWN5dvcSb5xQKCgdTQ5ZKQYxHrNt0mZg+uZ0eSUKg7ST6ulvMyH2CLnffh1mEBTDNkBXRlRwSRbZBHwaT9xdnrIrqLTIOiaiipamQkqqfPbN5fqbgDYNISRgRWzVRgr17KkpMl6X
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(4326008)(83380400001)(186003)(6486002)(8936002)(26005)(16576012)(235185007)(36756003)(5660300002)(316002)(2906002)(21480400003)(6916009)(8676002)(66946007)(2616005)(6666004)(956004)(66556008)(66476007)(38100700002)(86362001)(33964004)(53546011)(33656002)(478600001)(78286007)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bERRTkNMS3pGRmQ4U2pjb1hEZ1lheU1sQ2NmcjdKc1NrSWVNQjB2Wi9NejM5?=
 =?utf-8?B?NnNKeFROMEFESXU3YTMvckY5Qlprd0VMMEI4VjlZeDJLVUU1Q25oeVRJYWpF?=
 =?utf-8?B?a0J6bktVSEk4QlB0V1Zzemo0dFJiak82Ky9KeVpiSDFVY0U3bkVaYUNLTEhJ?=
 =?utf-8?B?NzVjdlJtbTMyZWEwV1BXUU43Sm44d200dTJzR1B4OEtFYUxVUVd0Y1RhNUc4?=
 =?utf-8?B?dE1OSGwybXAydVRrQ1h1bm5yaWtDT1lmY3ZINkxsM0YwenVNMGpaTjVLSkkv?=
 =?utf-8?B?TGROMkI1Y3NScEhDMzFBcG8zQk9Hcm4rOHdvbGVSUU1ydmJZYzZnUmVyb05N?=
 =?utf-8?B?TnRmeHNaUm41dHhDcVd4UEx0YnVCTVFjUC9xVDh5NHBqYXZtUW40aWVoWVdM?=
 =?utf-8?B?MW1aQWVIZ2h1QXFVbFhSQnlld1ZSeENzclVpbnY0d1Z2VlNwdlRzcWV3eWVK?=
 =?utf-8?B?aWJQeFFwV2FlcWZVQXlJNUgrd2laSDh1N1pSUkdjNVF1eHFMN1JlUmFrM1pi?=
 =?utf-8?B?SzM1akE0MXJaM1ZvejFRcWhKQ2QwdGxJWVFIaUt1bk1WSkFtVW1CaktISWpF?=
 =?utf-8?B?NUVzWlc0cDNVTTR2VlZOR2dVK0wzUG9IS3prVGt3b0VUZVBJUTdoY01wejNY?=
 =?utf-8?B?VFZJWGRZSFJmNEVtSzN5SFBiV04xMi9pRjZvM2VZbWsrODFNaWJyOS9iTDlu?=
 =?utf-8?B?dGdzZ3BsbHl6N1NzRkRSMDExSFdCcGxJQ25icDNDRDM3OGduVlkvQWRpK0ti?=
 =?utf-8?B?ZEc4em5PY3E4QzduUzlDQW15aWlBZnAvc0VxdXNrZTRrSkdWWjA2TjF0aTU1?=
 =?utf-8?B?cWloWURuZm1HN1FKaFA3MUhaKzFheXFvanYxV2FXMGZxKy9PTjN1Snk2VkNj?=
 =?utf-8?B?U2RQcWtSWlloNWlraTZ2Rk8yQ1RXeHVsOHNwVU55Q1VyemVSYlhOVkFvN2w0?=
 =?utf-8?B?aHRJaVFFOFg5czN4eTMxNWhCWEpqYzlZSDJtczZNUXlEMnJLVWx0S0dKUGRh?=
 =?utf-8?B?QndtSE0zakNEemdncGUyYUp6QnIyN3pnUjErcnAzN3hjVHJFYy9KYy9mbTJE?=
 =?utf-8?B?dnhNRkR5a2haWkxqUjFBU2RHR0ZaSDQ3WUFhejQzRHJhbVUwemN0L2Z2YkZm?=
 =?utf-8?B?anZGekI0a1Y0blozYlhhaUxWQU0zdlY3aTlXU2JtR3BQb2Z4S0JNTnZ1UUpa?=
 =?utf-8?B?NmlseXk2cDdVUHlGNCs1SGZSTjNhQmx1VmRLakNNVUlHTWRZSS9UaEpzTnNQ?=
 =?utf-8?B?RVQ1YWVnQXhHUVhDbVJ4dWIzd3FJQVNMbHBHTElZSFk4Sk9SM2hlUmpsQVZC?=
 =?utf-8?B?VDd1SWt5ait4dy9GMThjcDVuNk1IMEFKWFZBMmxrTlNRbWJmRDltYnlBYWRL?=
 =?utf-8?B?bDZxanhGMS9seHEyejNMc0l2aHozaDVUR3RQZkt5TCtJSElHQ3RQZHRndFNB?=
 =?utf-8?B?eSsxb2Frb2RhRG95SlBqUmkxbk0wakFOWGErZitsWmdYN2E4YW9EZ1lsb2dB?=
 =?utf-8?B?OGhHWWoxcVdIWmE2WU40L1RLTUtEMUNnSHpCVk5yVTNUaGUrVUtSODkwSWFh?=
 =?utf-8?B?U0JHMVlMSHZDcGFBaFRZaC9ZS2tjMGFGWHptdVZPcGNCTlh4RmlLZDZhb0NZ?=
 =?utf-8?B?S2NsWkhxSTlJZ3hjZlFnR0xSWDZaZ25DdW9qa1lORW5JUFZORTV2Tkx4M2Rv?=
 =?utf-8?B?Vkw4YzZHbGxGWEladkU0aXYyajdhNFhvbW42TTRXWVRyWHBsZTF2U08zbmU4?=
 =?utf-8?Q?SqmHORg/hTjGFkmB+U+COxN7DaSJ39dXjGWOpGZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f3d1ea-243f-4ace-961c-08d947a8fbfe
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 15:55:35.9398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uAbSD/pRhv+Asr7wnL7e1RAUHSl2qbJGa7leHPuPTrXls/2n18PMyeoSYhouqr93
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4373
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=_MailMate_553D7398-F86F-48E8-98BD-45F9BF183DF7_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 14 Jul 2021, at 23:35, Matthew Wilcox (Oracle) wrote:

> Turn migrate_page_states() into a wrapper around folio_migrate_flags().=

> Also convert two functions only called from folio_migrate_flags() to
> be folio-based.  ksm_migrate_page() becomes folio_migrate_ksm() and
> copy_page_owner() becomes folio_copy_owner().  folio_migrate_flags()
> alone shrinks by two thirds -- 1967 bytes down to 642 bytes.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/ksm.h        |  4 +-
>  include/linux/migrate.h    |  1 +
>  include/linux/page_owner.h |  8 ++--
>  mm/folio-compat.c          |  6 +++
>  mm/ksm.c                   | 31 ++++++++------
>  mm/migrate.c               | 84 +++++++++++++++++++-------------------=

>  mm/page_owner.c            | 10 ++---
>  7 files changed, 77 insertions(+), 67 deletions(-)

LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

=E2=80=94
Best Regards,
Yan, Zi

--=_MailMate_553D7398-F86F-48E8-98BD-45F9BF183DF7_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmDwWnIPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKO5sQAI0b6pW/ckJojBHE+xqcCnG8PIGCFAtsZ+dz
HutnOgce9yaOj9VhxvmqIKAssrNTmPV1p8ztO83XA3F1unzlubw9GXMN/NjQ6seC
YzqiqYNRCcrw7XnWgGJcJFNBFUIy5rPN7U7JMp6j0jNO+mAhItVY4qm6hIrRih4z
PyhzTk/sS8XTUQSJSF7zMOynMzwK2nmW4QCM7Pdu/ByhfxcdlIUcHzczc5OpKJvr
Ddj+kdXcO7iOjaKQsRiDklDzVDuBGOv15s4qLIIpdNDbieIUkTPWrMIiEhmW1w3m
AWDVpQgafsZqnYCeQ00un+sbMS2uFE5TFfAiItU/9avp2DAYjB6eSegPeug1hSn9
1DdcltxSOGlSn9c2zivRoK8msZLgsEnyzI4WeIPSgbS4/2PK2evpbV11/hqj8JpY
eDqKCOUPkZVbhygL+JwRVa/YnJiYYUA1lZFwI9ixqoV4s9PX4HXWQpYObTtXqQCz
4ylIIniTg8gMkCdVz2WyeqYXVoZU6euiTKRgFPnLm8CIT85StfPkBw026vFUcr8U
AOyvinMuPLGcJuUy5/C25AJCkXV2hxqqj1GWfaXRh30Ju9yUHI/1UAHJPlOVwplx
JM258pbdMRCWJsLi8QBttK6jHpbSzDJhShjSQj8+r56qxEoRGnZG8fBXEspo5Cyr
MqITuNJw
=OeAL
-----END PGP SIGNATURE-----

--=_MailMate_553D7398-F86F-48E8-98BD-45F9BF183DF7_=--
