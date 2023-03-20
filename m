Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BD26C1031
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 12:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjCTLFu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 07:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjCTLFS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:05:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C199E381;
        Mon, 20 Mar 2023 04:00:40 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32K97edr008241;
        Mon, 20 Mar 2023 11:00:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=klKIAm5TZKP2gRqNT1UGmdh5NMN9LQYDgEe0TlG+1w0=;
 b=Hev8DskYDrFXZys0c3wqo3NFV9yNbo1TMTUSln2VkUHNL1eKfvtLOsetEQqlGMrCgHoH
 dVa8CGHMLDv9cQiOmFbvU9ONTmbWKqqlMPzbVXBToOyWJ40XUjQZQ6jpUNmrfzq0i5Uq
 fZv6Rc9U+Gbn+t6xLBR/cdo8J9eDQp9KXLZvAp/K2Uejx0upw3J69aXOb7Q5hl2XXtFx
 hAn/zVLKH+kjvS26MugufAq1GaWb+kbxkmc8TxJO+3UUURKR7OcyumPyTNgkVY3FTmXk
 hRx1cRXGdjyMa4gSHVIshXiqltpcyXAPSdpN6x1w8nsNLlYCAF2OyCMzCx/5J4YcPFEp BA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd4wt3433-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 11:00:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32KAbKpf014427;
        Mon, 20 Mar 2023 11:00:24 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pd3r446dq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 11:00:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=co5OoUdQNSBFwkR790FuTzmNMp+3bqybGYXi11jMhz3JlM4RT/oloz05a+2cURw0bOjpye/+zuYBH/a1/VexYZtIwkI20pSe9MvrRMFzWIvzkQLm0D4s9W4q33noN7LIzQObj9y+XNwTRGEC2R321hzzuF0pxoWWuMPp615/EMpQiCUY1Mg8yIE1d1135ptqA1SIDULBDb2F8hi1CIkMZtIfWsHfNvUOESYIyXYkEcxrhZ/kGB22ONjH/CFoiC9H5VGSgnv87b56jc/wnd5N69R5tp0vO03BHK0JcqrB2dUkIRC1qdSty/LoyULcgDXsET3SRWVzxt7xhmpbexpLSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=klKIAm5TZKP2gRqNT1UGmdh5NMN9LQYDgEe0TlG+1w0=;
 b=i1s1NsSQ+7zDJun0XlYgN6mKiO/Cx31lW6DAKgwuU0/mWaElsGPR80LqvHyS1wPq0mGI7UvCY1t4e769FsbmqvM7vr9AfdRWMTo7VnyLRtFDmNagZFL0Zr1RHwKGiWoaMZIyWqjwfC97HjG3PgNhcSF0gXrrgeNb427G3n0Cq+J+ZRe2gtqC7aOTBmpFDgWVnLRuDGjQGJ0+BOIQbtoZWfP1T+IpWqwsZeXkXxQV6xGFyCprzdPIXo1Izyokv+jcwUA9Qn8NFaDOUdAgNO4Bfi7NajF+WMgLbPjIs0RCbikLTxSrNxyfg2kv+FJ+Djv352Q5/vjSa9SnM3VmrZiNAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klKIAm5TZKP2gRqNT1UGmdh5NMN9LQYDgEe0TlG+1w0=;
 b=boEiVdUzry1pflsrB0XO2R8APq7JxZK1nW0sFqa9pi/qjknaxBxfJnmjzazMaUu6fuMNJnETHoaWPLdkF3iDNUWO3y8GM8ismvkvDFhi6o21mBGjcAll4RwEKvRQA7kiq/sbkjscOIklaXb51XSrBkW2aHhntZcoQRxk6Y6hny4=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by CH0PR10MB5308.namprd10.prod.outlook.com (2603:10b6:610:c6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 11:00:21 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 11:00:17 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Nick Alcock <nick.alcock@oracle.com>,
        dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 00/17] MODULE_LICENSE removals, sixth tranche
References: <20230302211759.30135-1-nick.alcock@oracle.com>
        <ZAJzCvTI67NgbJiY@bombadil.infradead.org>
Emacs:  impress your (remaining) friends and neighbors.
Date:   Mon, 20 Mar 2023 11:00:17 +0000
In-Reply-To: <ZAJzCvTI67NgbJiY@bombadil.infradead.org> (Luis Chamberlain's
        message of "Fri, 3 Mar 2023 14:22:02 -0800")
Message-ID: <87ilevu1q6.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0344.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::20) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|CH0PR10MB5308:EE_
X-MS-Office365-Filtering-Correlation-Id: 768f7194-ceab-48d4-e342-08db29324a6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LgrsJHahYgM9SFsXSPOCeHei5Qu32kjlulgEPAbRkPyfxrEmnEn2glxwc3rPWzq29YddV5bZSDYm1yj0Id0Yq41Yq6mdHHEr2FxiLvl/tK3LpvntyubTjxUZKWkqbXIhwr57oVjm+wcMzVcc8/56g0Snny2YqGe2gJT1V0o/otomXdSwAVz6CKSGf12+Nq5Ou5aIzn0odRU2bpmE/jj+u2QlSvp2VhpniFh2Qx+qxujgWwxzCSII/6JskJtV9Dtc1UlI0J20pydiiPI98hXJjtxEZYknCpbwwsorvJT6PnVlGf+O8V17czB2hlB3l5/bBhZvO/vCpqaaSrvZDSX4OCclcWCYTTXdfBU1gVW+w32Zb3bnXaHIlQCdPCqqk87YcqufCDI0w5384i4udBwChVvomMVRiaeN07gC9Hxm5yiKNXrnYLeyg/ePbhkJ7zYxgrJ+Wh73KsRfGGFmR2NcX7H900jlIpYgbtetqiUlacs26iSns0ayfruf2AXgEWGQuDvvZFGRoqeLKrLZzbe1/EgR94CjSIWcLFLTNvf5yyeF2+RU3HjPL8TwJ5jk4ndKJYQ4+4dQ8uMT5SmyOt7eoFalbAigiW3+ZiqT7msD6etowD/cn+p6d82c1WKQ3OzxmdLZbSJ9u5wCKI53cEketg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199018)(9686003)(6486002)(4326008)(478600001)(316002)(66556008)(66476007)(66946007)(6916009)(8676002)(186003)(6506007)(6512007)(4744005)(8936002)(44832011)(41300700001)(5660300002)(38100700002)(2906002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Oqia4xyz+QwAshmwcVuxG7PDuNYb/M0QXo/rVBzTYIFslN/71SgN97piuNdv?=
 =?us-ascii?Q?g2pP2XfT6Ts0imgLmdC2IfJr0CU69ybas7AP2UZ35CVlhZOmbrqdL2H+kjXg?=
 =?us-ascii?Q?B3WMkg+z8XCib84wfM7am67ujNkkfwjEqbOwO8ypnGH5RNgf5fpXjaBnXVBK?=
 =?us-ascii?Q?fbUHfsrIbxMRqi64J9gaEibFfr+dKrdakszeKgt9ThwpfJx9hUq6+0W8rUrP?=
 =?us-ascii?Q?WDLi17Clt1m98Lr0GXRA9FyQuvavsGwkSfR1RnSf/wk9ejgAEvHRc7Pyb2S+?=
 =?us-ascii?Q?EAyv8O3nd/+mzeAFVyyLTVSQCXNjcF5OB2ZcF9sDwINlDZywz94o0YpTcvbL?=
 =?us-ascii?Q?RSxdv9fFSXw5g6VNxFNZCarLRNfEMEDqtZWvBlYhGmkvUHGloLJEsN2FnCkR?=
 =?us-ascii?Q?5V+Aemkv37NkRs5R/820T7Oca1ovmAAXJdQ5+up55yMNBrrO+wYXEc/OCxAI?=
 =?us-ascii?Q?AQr+rtX+1nN2sAyHMIoJXZWE7LsjMJ8Y/r4B+f1CGYHkCvLHg72WGxeuDv9U?=
 =?us-ascii?Q?l+mlfkf5DrYJuOBLlwhs3TW/v+g7aJw2dG4Kuv228Ix/wVTZkQW2XsWJjP6v?=
 =?us-ascii?Q?4zhROygCC9FcC07WLxuQNZuH5NKCSaPctFLbNU0LqJa0ICr/N/7sfa7+neKZ?=
 =?us-ascii?Q?x31S7OJ7Y1gws4O7kpbCJVLyBDynOVA6l9CDIK3CVA/4p2c5V0IAhb9pPOdI?=
 =?us-ascii?Q?7RFQ+GAN9o/niFpp/oSJ/tz5tvtmW73opE+0Pr61KP29WyW/ZUN0YEXb3pk5?=
 =?us-ascii?Q?OPjEAjZjpM5ukuTxrPkpKHtwql71oDIvcWz7+CsRSPpZgwGFXgJeVhu20w4l?=
 =?us-ascii?Q?ENLUwA+fQuqgSjBclHcbgarD6XdeOu1lrtcyQDWpG0T5y0s00rHwA37hqy+I?=
 =?us-ascii?Q?ppNmcFdoLVcFrz5silSbzqFV3WiukHrZ50ZT4+/JhpFrOsd30CHaCYX4VWZ0?=
 =?us-ascii?Q?l7P4wQYzsRvH4ddqLaDvIbMwCyeu8NEdy73zEB7aQA+XPrXimjq1peRdKvOU?=
 =?us-ascii?Q?DTthwb2q73Ok3RZU5KS5Ra8Rmx97ugzaOBPpCcZ+cet8sqD255vZpT0Lmtjh?=
 =?us-ascii?Q?TF43GTu2N97/xAe4KzPIpWzKeYW99BjRyzQ4hh0E3IrXXBEx1nHg+yHB8S4V?=
 =?us-ascii?Q?Eeb5+RiqBYgvf6FnbcOTpAOJAMNItcxQz7uU0D3C2cTBBhQp5ElWOtjd0bCD?=
 =?us-ascii?Q?HzyZ/NmGfwe72tREnVf5rkPr/AXa9VDC/iTZiSrpLT6ZYuXaDjhwEO/6PYk6?=
 =?us-ascii?Q?huLUVQmh+BvZ57nY0CglWJJ0ZrWTOB4hqwl77wImOkIeuApxX8vNi8NPZEoU?=
 =?us-ascii?Q?S3qh7W8w6KU7qi/GlshpCcg4Re6y+5UEdMlhJHovlput8fSy8BEtEaCI12YO?=
 =?us-ascii?Q?fZzakgUH1ZoUw8m39YnGDordhSgNjBxJet4jA1Ra+Gpw1xL/htmo+7jcgkG9?=
 =?us-ascii?Q?WwmQ0qx9r9gmO571mtCVqoNfVV/GwTs754O4jvmZR01v9coMOU9FAvd3ge98?=
 =?us-ascii?Q?UYuvbfz9SIGyaY/NNvIezea5xtYkQAULDd8Nn/85E2KVRB2LcUPhxiVyynEo?=
 =?us-ascii?Q?rFfIRJ06SZjXDcs/XxmqSPsf4JLDt3TkSlV6hylhTz0Dm7P3/KUWAJt9kRLo?=
 =?us-ascii?Q?yg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HkvnAYZS1D1WQNMHqOCPC2iWQIPAu2tNcWXvUdCz6g+FPKcJC6B5NqoUOh4WULDq2fqEDmbwpWGqf4I5cfzq6uF46lfN9W0OV6DdfGW8YBoqy8DTZEx0ub6VqJCTa6QLQ7BrA5ndnugmyv/l8llBMp68d/Osms5mLoerjySTw9FoTTF8zUnn3ynlJ4V55HPFoxNVS/r8hEYdlCSSDxIw1NBxRDFPc2v1fGQGjdeQicTDWr6vecQjRsYiBXgQm/wjKy9O1DVnVagwvGqKG/Yd9YWmJo6kK5rQwwzX4Yxszur0T4sGN3v6fqtqSvvXpDPlpuWxlhqRjSit3YMfbnL0f4V3t7/m9X9cIhpDhxHxhpt96SCf1deiRMEKOC/Oe/7ZxSfansvY9MrMiZiVp35p64qTeBOE5gZJnXdrk/9kDaIdc8T4+JZn3lTsgfKwT/JLyMtNnamqI1HjTUuhvH46qg351HhC+mL3KfkbOcQzhKZVcozPBB7iXsgpfM608FBk7iKoVpUYpyN9VCYJAM7/5u7+mbXTp4T+QrMW06dvJePJdoaw9wHqP6hQSBdkI3viXQ6bJTedeaWrauJWRfhQIsQ2VAmK5g8MMJVNg3/rcgE0R8wcrKDf62jKnWJ411RX43XknLJe2A0HCn6zM20T/YjGuHFNIsBf0VuUK5Lq/ZhKFxqxj8tbZzxOJP8aqnRKJtuQi6boheIDPBpti7lcS58ucfJI1ifwQ0Ilaq4yDU1m5qxIQvsCnc1aZ6vzChyznSzkc52fLjpLa7iTtBTGhcwHbzknNgipvdQmDrHQibh56K7TFfKgb4HFlOxAmvagqKk4REBIXIHV7/agT/o/YWZ2r3nMK0O2jSSzj33VkBryq+lL2a0nWVamegfQXVHH
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 768f7194-ceab-48d4-e342-08db29324a6e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 11:00:17.8348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xi96LBpaSuL0Kj9nK5amig3vQCiR7UkhaMPA/1/aohuny6b9lsjv7ZFDHkK+q1wnZMOMJLKdxlR6DJVrRfTJnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5308
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_07,2023-03-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303200093
X-Proofpoint-GUID: 7WTFMFq3M16P8NIN9-Q0BavUdpsdsPS-
X-Proofpoint-ORIG-GUID: 7WTFMFq3M16P8NIN9-Q0BavUdpsdsPS-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

(Sorry about this, MTA delivered a bunch of stuff very late.)

On 3 Mar 2023, Luis Chamberlain verbalised:

> Stupid question, if you're removing MODULE_LICENSE() than why keep the
> other stupid MODULE_*() crap too? If its of no use, be gone!

I wish, but when I tried it it broke stuff. At least some MODULE_ things
have side effects -- MODULE_DEVICE_TABLE, maybe MODULE_ALIAS etc...

... and also I was getting complaints when I sent a tree out that did
that, along the lines of "if MODULE_LICENSE is the problem why not just
remove that". It seems one cannot win here, both options elicit
complaints.
