Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830157B5EBF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 03:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238959AbjJCBlF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 21:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjJCBlE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 21:41:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F07CBD;
        Mon,  2 Oct 2023 18:40:57 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3930ixlJ027477;
        Tue, 3 Oct 2023 01:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=xCY1O+Tt3W/81LTItALU9iTaEUy0t9QT/JtlpeqR0+Y=;
 b=SRb/tzZYZq4lc+NqKA9yL+38attxYFVLK9PpRRII/zpiqsK/CD8s+7645aHT0Pr/tASR
 VcW2ELQI4NXYW9+tWmU2EcuUKo013ZYzJ8nIGauPL+iJh2tMOd4ODv5cc2A7C2J6WAkZ
 gTg8q3ANjTZJvwS7Wic0Vdf6WmsAQvNw/X0LizvZdPwdCHm6+xbmL2rL0yLCIGpSmtCA
 Z6b4QyT7NTp/0rL3ljknjbLC0T9KI1xBseQGprZGx3DMJ/aX0jp+slemqWDMn1ZYbKHB
 yFDPmOhe0RRwPGEGIuRkS6VGxOy8nIlqfSk0oqRSIPITDcVV9ceCIsFAbXgBfd9y85GJ +g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tebjbun1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 01:40:46 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 392NJ2Me008651;
        Tue, 3 Oct 2023 01:40:45 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea45th7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 01:40:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4k+sZHD7zrPswWfEKljX54Zp6D5xJphWCDY/Irovewdrk0N+Fx6wj6BQua6vU9TOcxKsyLMGJlWroJSFW1s9oYmeac4JFYz3iD1j7yhdj0pXHhr77NJFaHk0K0ddP4lgA+mSL6HhHuHsPBg8HtV6l8GBZTFp7Cvf/J+ShRxM332VpT8fseU6DSFQj2B7cY96jhlZ9heHFcHAiYhjIk3dkLbguoVnwN9MS/2XdBEz99Blova+JX7oD/2o3Wg50yMj+i39CebaPNnrsNRbiFY4QGRQbSeK3z9Ag2RNgLq9s8qqgQhApAHCInyet1fbuCeQ3HtYiEWRM19WUANcMCUyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCY1O+Tt3W/81LTItALU9iTaEUy0t9QT/JtlpeqR0+Y=;
 b=a0dk2J7Kyk27LQrhXU+r59xcA70irKs8sbNUh/kO039MiHPFqTJmEne8Pb4A/QPbJTdGgR2bCcf+tDKbF5RMif+7DI4f+c8dgyYGuDQwGd6JR3328E8rYyOpRBD8AwtO2nClT+mIe4Sb4VBXpvtl8MYadwCGsrfkZQbImiEu0DP/CvoqwALT5SSzJDBQ90CLht452axA+ERh8R/QvWhwCCIkY+gAaG68ILKq98HyIaYYo8XE2F4+LAyvggy5kQ7yn76CKOyrx9MtRW70sM1z1H9S7AXQddgv+NPsxMpXahhGdmh6+9+iHzf2tQ8XBAJQngc6ZE+PILgxrDFzghGclw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCY1O+Tt3W/81LTItALU9iTaEUy0t9QT/JtlpeqR0+Y=;
 b=gnwbzclIZh5yFli/59xBYHEbD0FwA/ntr1fZRb9NNT468s7Mo+C9P/y9EGtoeCoizV9BbEsZ9/cHVIblpw21zLNqXFdieobQi/+NkeMOGYpOOSUciubtltBMszpgB3O1x9xmvm40Xu2nGIfKHrgQBrzIcEr6k8rsZMzzExkisZ8=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SN7PR10MB6953.namprd10.prod.outlook.com (2603:10b6:806:34c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Tue, 3 Oct
 2023 01:40:41 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%7]) with mapi id 15.20.6813.017; Tue, 3 Oct 2023
 01:40:41 +0000
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 00/13] Pass data temperature information to zoned UFS
 devices
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq14jj8trfu.fsf@ca-mkp.ca.oracle.com>
References: <20230920191442.3701673-1-bvanassche@acm.org>
        <yq1o7hnzbsy.fsf@ca-mkp.ca.oracle.com> <ZRqrl7+oopXnn8r5@x1-carbon>
Date:   Mon, 02 Oct 2023 21:40:39 -0400
In-Reply-To: <ZRqrl7+oopXnn8r5@x1-carbon> (Niklas Cassel's message of "Mon, 2
        Oct 2023 11:38:03 +0000")
Content-Type: text/plain
X-ClientProxiedBy: PH7PR10CA0010.namprd10.prod.outlook.com
 (2603:10b6:510:23d::19) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SN7PR10MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: 76787051-da33-4c4f-91b2-08dbc3b1c0d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fYNCa01869tmZs919/BlSyInfSTfIM0a18ol9Ks/fky+NenX+1XmLCDwXe5d4oM4RMFjyYXzZmagkh415trgPjLzai50q/k/GpnLWbcfs9pe9+M5hKmg2xxYGb5rZgKGuaoNvDkglauoOsNMpdjhybhfcpJh3+5uf06WqyG50Tz19DcZJFFco2BBZrXXKBjRJ9iLo0IKh1AfzAHtANfu5VxWgN/OZvR7OnIg2E5KsyA00kZb6VBBmMCYkHZcmsP1XQAItJUaNBRAkXVH0BKHIdL82SHqtgL8jP0tAihWdsHclNUdDkUAr0w81ikQdPvbjMfAmmGUm0T86SND9NnabkJfXoiQfAUXeidail4NP6Emf/gdgwqm30b/UdFFP9N/2Xjqkg5AyMl4XcDPPcd0b0MjZk4t+N+xkMdoaHKwiIScsCIzvdFByj8WmmR+kETwsp9giyN4g3bwwRB8UdIeBNKKl7NLPTb1/O+YWVHFCzKMsgj2dtVHvSyY8Z0wbSc/BAlBSoFBw2guoZluwUiryGYnEiquVNTbJHvnYSpoHFTIVj6ia/yGssCOfc1m3bz7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(230922051799003)(451199024)(1800799009)(186009)(66946007)(66556008)(66476007)(54906003)(6916009)(316002)(38100700002)(508600001)(2906002)(4326008)(86362001)(558084003)(5660300002)(8676002)(8936002)(6512007)(6506007)(6486002)(36916002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pPCW6Q7eSrGBVKuh8z2mOFt3MDa1+8LTSZRmrNm7QQIzFBAJ15r2Az7opUi/?=
 =?us-ascii?Q?Nkj6XuBT7X71u3blsjmeUiiu6HFCcj0S4GW6yoFO7F5CNtakfJ/xj24+VRkp?=
 =?us-ascii?Q?dNtLtsrsnotptYXsHWEjO+W6R/8ebdWSPxS2VeJkfQDBvcOspQCU9+G4NYio?=
 =?us-ascii?Q?BibVRKVoGd6VywHOKcL+v6uAHfCQ4FUzXN09/PRwus0GEG2rJTZ7Zplj08q/?=
 =?us-ascii?Q?ovsRblG9ot6mkDY3e3Xr7Kznws1RPhr+sSdhxrJT0buFlYgtkvGZtyK4/Fgv?=
 =?us-ascii?Q?I9qBmwoOta/rwo8BJcZucrAQM+XqrClX8Zn2wIYErWF/3w8doiNpbrGCWAwP?=
 =?us-ascii?Q?Cs2wU7IZBTD+sGcF5YQjEEh/7zlU6ndPiCzs1KCtnpMRZnuW01I9qQu6PXCZ?=
 =?us-ascii?Q?/jqLdER6r4vXSSJ8rE6QIvLUTxiHnWFKeNle2eZPm8ZY3ZtllyLSOqglBaYY?=
 =?us-ascii?Q?eWglm6PdOH6SZ2S5P5dHR7eWMOSszTSh6H9bNRP50vVIcIS6mDC/kf8yx5en?=
 =?us-ascii?Q?ZRzUBD7RDwhmvajuCvd0Ow1bLydU9gc/RxtqYbNrYvYKoq5xq+dmC2h43eB0?=
 =?us-ascii?Q?qCigJTDs3Rhz2TAbgkt1b2ZrAlnXC0nrAefl8IeV+9HVWjldjAGvP058yQK1?=
 =?us-ascii?Q?b584W32gZL6rAWwLHtL+fmqwpVj060E6/9VyNXfzNPtKvh5iRUJvXUJ5Maub?=
 =?us-ascii?Q?nkn4Ny6OaFSkSekLbyeDoQN7GrsbBFAFsMRIi2lz//qcWUJJf4WjzO3QzYnf?=
 =?us-ascii?Q?X+WgYSRYlvWGCu/Pxd6XVVMpZLr5wQXlPTcOVADMUuvjGZygX4m1f/MBcW/F?=
 =?us-ascii?Q?NL1uICmLk6sbu1XCsouquA+khHQNpj8u0TUcP2oEOFfnRjCtK+xMfzPIs4em?=
 =?us-ascii?Q?gH62ohdUHjtcUD6l9WCIRU6/HPqwfNW/JNCVDAH+qwAGx6E3S4pKaY45NUNe?=
 =?us-ascii?Q?Hin5Wnh3lu5Oea+RpmDAbmIeU0dPrxuaiEj2gzn0Rk+py+aTYHtMtcxSBeux?=
 =?us-ascii?Q?ENwSSzzYXAcf+30aMSi36uHJjGslEMODhKf0gLWHCp8obLVI8JrwQjiTscjU?=
 =?us-ascii?Q?BuO5e22sQJciivn0kra+bGOzoMCK16HNjjfkvtVqEvJkjzUwbDhwf9iMTFbE?=
 =?us-ascii?Q?41axKbbnxVyYe6oMXASLViEah9h85C+5hYixPyM+b5kzLQxoF/v1k1jfsgPu?=
 =?us-ascii?Q?tYcRzOLn0SHXKPbtWKfAjLtPzf0auMs96Th5md3IQYPAj0aqkQ3/T4lWMzmq?=
 =?us-ascii?Q?V4LdNkVjQVN8LoFQ6hXVJ6zDnQLSJrJpjS7w8j26nkWp23efEr6geEDJ11PD?=
 =?us-ascii?Q?7tRETtwLtL/NZM18nyBxO+++EYd5BR/weT4JD4AY6qR0yDhBIyP2BzccYEMW?=
 =?us-ascii?Q?7kQFtpt0LtOZ6asKc/jHdKz9VCDtNOQlUt8r4wyNs5JnVMg5Udpb+/XRDDAw?=
 =?us-ascii?Q?AduFif4CBP3nrgsn2/4STUfPm2CXNYqbkr5WnafLBxXTu7SFf8U0fv3r9S7i?=
 =?us-ascii?Q?wycNqWzZRaasVDXqPZKsVPv5TdSaEpJoA6oOiYTFctSajct25a0BW7rfZ0eK?=
 =?us-ascii?Q?BKYrb6nKXAClkfZROZbeMsoZevMgOxplZuHlixm4SlmVfO1mV3SiAz7YSnww?=
 =?us-ascii?Q?CA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ony+xM+dNwTIU5FAGQzu6SHedCy9OY6mqgp7XVtzKt9CaW0ojoOi/x7ewflQRmmQvK/NSzDZcgMm8cMzRXqdGJZZ9J3dOV8ZCSJxaAgZipiQWivxYyuxERjKG9BBn+vzhh3deQl8yKnQVQ0X0tcxmw6eqQbMLdeLH1giIuuu8IFHkEq+66Xz5BqOZf75C4ydoTsUtMOwG/R+xKH7g28jAUweLnxTm+Xn/XNDg+Tn1eK9PYAFTyVU3tjnzSaYUb8nU9jhqgRBK9O/1MZRI6XDEkmSS/6f99a/8JizWKiHcGAvji7wD4baXYhwHUQ4+wwxu8dXY4S33lRNXgrvuhKsS5gflMw3i8leCzZfuVaXr+nqXtcoigVxJWm8ihwCd+D/hm30W3u2uJN3G/2NX4XYg1nu0XWKF4fnsIKEQc1QEskgsWnr9MiPL27ZtpU080Hv66/I8LkA37QEpEiOd3FaEmsEuV0QD6ODOyK4itnWtgDEtvmyyYMQhODcDcDWEqQphZcho6Wswg5rnv5FC8HOUhIU3Td4O8LcMeXnsxBAZ35rsOf7Re9LqrQQQv6YAtWuFQ6VG/bP4nGvpRLobrPtLjT5gj+psG+wl88kpk8L5Vo9Gj5Eud2EWAH70P6LY0ZYpkneuDJ503H7CbJv9stfHb79Gkj3hZk6xmtOgx02GIWGj6+4DE2mgPnBADZEbUugSPd+xHgIAX3UgqQJ3RJubmK5YFxnWdCTK81DYI2Ng0Rgf+iTpwNB2cYGT3cddRWBuI4WYkJrLCp0MAlc0xteY2ESP4VsRSJn1IAteIdPvxPEKTMaQo3MORTnetDrjcNCPWbvsEOY62wp+cgU7VHm+602AjAGqXANDuSwMbZuKi2C9Djq16ZULSe4u0uKtk54
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76787051-da33-4c4f-91b2-08dbc3b1c0d5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 01:40:41.5838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ck3FH1bqQkLe82Fv3xD7Is/dTOKsl4wBp0UuR8rL/XrpaTW3ediWD6b7z3aLTV78Lf8sddbw2HdL0XrhaQtP9zJl7VW+I2unfPtvKnKwCfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6953
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-02_16,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxlogscore=586 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310030011
X-Proofpoint-GUID: U_7WwoGtEDkJZczNywh7nP22G6UzfOB0
X-Proofpoint-ORIG-GUID: U_7WwoGtEDkJZczNywh7nP22G6UzfOB0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Niklas,

> I don't know which user facing API Martin's I/O hinting series is
> intending to use.

I'm just using ioprio.

-- 
Martin K. Petersen	Oracle Linux Engineering
