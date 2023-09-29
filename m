Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4B27B301E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 12:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbjI2K2s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 06:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbjI2K2a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:28:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2667C1A8;
        Fri, 29 Sep 2023 03:28:28 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SK92ww009603;
        Fri, 29 Sep 2023 10:28:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=cVuZiHiJsxm4zbLeUGXsGcN0aXuQSv3J86nYfRkukD0=;
 b=AHw+n45aLWAP88COCvnlkcGWLywqpcYoPdX1AEbHF1xjFpqf8Qx0vH8OUOHxv+ytm61s
 T18+CDcRz/RBJWGdYUnUdOZhaYNQ+ZRc82Ows1Vy6yzTlJU2osjFjqqKLwSQXehnPaTU
 +gXB/sDKdVTlr3UsIK7C3o3jNVTfMhAQZRuaBf5ZhRlF00xOkunEN3CF2rIX1IudiLBA
 F20tiB07WiYW22lkYu+lvkbz7Ct3r+k84YcEpoxyQJHOi7UDULHe5CmOBNMgFW0wlNBd
 bT1Lkq/DArNGetQLjzPrm1M5rqpd1LuxKMIjDlzRQv6wX6NGaC/OM3JRd+vUL2HeHkjR cA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9r2dpjk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 10:28:14 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38TAKh39015906;
        Fri, 29 Sep 2023 10:28:13 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfh4vr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 10:28:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzCLXMdpPj+IT4vka/mnL7osUe0cexKJUuipl7r5s2LcmnuVgYLTCWX8Ap0KbGuIPyKZlheFE8FIsdtxSxxmmK2g7f8Y0g3yiYjf2z6daG0GePImK9BnYL8YEZHdqOTDtNyxdi/Q4V+CXAXtKG/Ow1iGwCBNzxdv+OqREgGVdbn552qGEG3WKYrZWSLZhYwbjB/QnCotaln0X+ygaRzuxW8EtUR5ed0I3OoouUh/cT8w+BZNtPJ4f3i82O0IX/KSfULmJ5RhI9Fx6NVZQ1FDctYOAlz4k7CqgCDJmx9P0YRbSx6OeZxbQ2kH7AK6K3w7EAgLcLw4zTZMdqbwVJAZug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cVuZiHiJsxm4zbLeUGXsGcN0aXuQSv3J86nYfRkukD0=;
 b=TX+HiTjIT3hGRJxiQQFtKRCU2AXEN4g8G75cbHn0Z/ET/OTnDaBZkZNbd9yVTYSTWJtE80iyBr5G4t5TUzIYYsjBIbfEZPo/M2IySfAZCdBKHv5cl5AMRQqIZjZEe9dRaWVnfYPkuUrXjmOH/9sKjJFbpYj293S1QJBDL+WptcXrFH16FlBz/Gft/8RfwZqIbTr+j2FJfR/W1LjMw8SZqRlUYKo1qz1W2FtNpHeaMMrfjEz5oCVSyoQDZidrGDqiujNcHyUqRvFNQ5UQLUawUn96T56k3/Yi8Dc1DH+PKDk2AMaAOo3mN0NRopbFxr2B2rBJbbGY5Wm2t7NUiQRsUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVuZiHiJsxm4zbLeUGXsGcN0aXuQSv3J86nYfRkukD0=;
 b=xbXLjL8WHByauy5ZIRMIXSlXSdeenEqmbHK1sv5VK8fIKGUvQPbbbXpCNtVTMgo/eEMQMWoi2SKYv4DELx3bSbvF7ociCs+v0eZ4iQP5lopaNy6Zr2f5IvIjSSvzv7tOqhkjNGsBOeG/eo2NwiTFpOeB33ilx6PyVJBkK0lRvr8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6153.namprd10.prod.outlook.com (2603:10b6:510:1f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 10:28:11 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 10:28:11 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 07/21] block: Limit atomic write IO size according to atomic_write_max_sectors
Date:   Fri, 29 Sep 2023 10:27:12 +0000
Message-Id: <20230929102726.2985188-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230929102726.2985188-1-john.g.garry@oracle.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0052.namprd07.prod.outlook.com
 (2603:10b6:510:e::27) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: d3dde887-7db9-403d-44d0-08dbc0d6c81b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vJf7GJ35ZFPwM9xrdi6jsmHBYVqRaVAwPIiBrg/Ki49DpbG2QFXB64RhrMpAhW6FdCblIhmZGEqG0EiaqVDfXhg0EnIVtzAKMvUh3M+wHKZPuTq8ji9xkPVsYdHMGCNzgtXl5mtlbXZ81cJCMlgr+ONK/EM8aVwrop5+S1VKH3UcT9z4Dk2WibLQwG3aSUhN1ZfGeV+xCrQgNq+qlzHWQVa4479cyZFA8t8hepXqMNG+iJ2u/d3LUC9OJGviL+wUSYEczsyIy3zapV6x0xZPK9tM9wPEoYHiMPC/CstQDLh73clj1nX1ICc2dluCuGgH+KiVY6YfSgAkTGCH7vE6nzH0myAPjqYtN7o8c3fw3N5pBIcLcG4Dp88qR2gfzJhJ3ASW4qCqODu5Yf9RavMNwItJSmaMofMs4AT5hHwIAV6ZJ0ZYMNRERgegUhuyaWvHhw6qpjoNHU1ao2vBM0z6Ds2VoEgHm/SyJyMDE2FB/T9hTiU5prAeRYkLnt2ir3fVJKZg7eBC+oBYkQ0rctqc6Q/eVcg8yqROnGNblmf9nXYYYc0Gs9vzOzRhW2UKR8BIcLdslvmVGqUH91NT1xBbDsV5ujQMkFQ+25k5rOcQ6ws=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(376002)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6506007)(6512007)(921005)(107886003)(1076003)(26005)(2616005)(8936002)(4326008)(36756003)(103116003)(66556008)(7416002)(2906002)(5660300002)(41300700001)(66946007)(86362001)(316002)(8676002)(66476007)(478600001)(38100700002)(6486002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EhmaTwfPMi/+q6vSiDySN0uI9VDxbQkO+RUP/PrGK0MgL5NOByw+ovpWPULB?=
 =?us-ascii?Q?BWCnRyjdh9gJXODthrB4CBdczOB19B5WhMACKvWAm5GHEpy6iWggOR2X852y?=
 =?us-ascii?Q?Tv9keusxIwINHfRA/Qo38wHT7L9IniEikHQx+16LZwRALWcTD9pxDLPgOWpq?=
 =?us-ascii?Q?403VfQVnZ3d/xBEP0xxOu3DjFU3b3mjiyYK9btQsumyhTdEdjA0gdjKymnS1?=
 =?us-ascii?Q?f6UlVA9QTzkfVG2s43W9V36bvfJ6KkMbl35k4x+pNyH6jVejDfPJU2xnxl6X?=
 =?us-ascii?Q?ji0eZOVGcIZtw76SetR6mAoPd9D32e4tOSV1HrLzi25drof/m5syxisfvrv4?=
 =?us-ascii?Q?dqV5LFgiPUkKZ5HP5W5QSSj2mZsEDeAa6lUFzeUE6mkkycFcuoFRzSJ1zcGt?=
 =?us-ascii?Q?O572wC/5AVgt/czGhNiw69YZYGYWLEwQ6otQPUlqQQjas0RobdF8xvFI1hpX?=
 =?us-ascii?Q?TqeUu/t4By/e+x1yJLuRVe8iTXRKIJAC1SSluFK2HmZjxIJRpKxC/yaxSnUO?=
 =?us-ascii?Q?Cu42pr7/AyPrjvNSI7TrnamK04TLBvWAaPAd+d4h88lH7LQNXxQFQGPtC4bV?=
 =?us-ascii?Q?z8CRKhb7Zy+1qOGvM0+nZbpS8cvO52UQCqMU0YYKT4ViLWERGyjXeCtj4QY/?=
 =?us-ascii?Q?2XbjWHEwZWD/wQ/2l9GZ4qJefAwAXuzn0w01rYmEFiybjfHnJJRDlUpF0FHv?=
 =?us-ascii?Q?pPOxal9KzO8hSYp5YXdcWlLy5JAafaJ5a0ULZ/2sIyzDW2lWMNAFTfavcjHr?=
 =?us-ascii?Q?O402yr0jUpa1nP9GSWnfMIJ6yF7UwYwW4UCS9ZxJMm/XAv0dKZPyoM+qPtHu?=
 =?us-ascii?Q?4ipQif2azVMJ/9e9QCo0mjwuDWARTdN6/y9PXV+qxiNArXkUF7LaZ87P5LSc?=
 =?us-ascii?Q?jkaZhmhthmGedl7W1ZyKQIJJRBKP2eUjs1Rk8XdhoRroSelIPCOgl3Gkmh6s?=
 =?us-ascii?Q?rrX0xvqK4MEYwGjtiIP4aAcJSGqJ/DLmAGVqkkgQssLiNNpdW+2M5B7yi1zK?=
 =?us-ascii?Q?o18xxXSMJ/4NbQaZX76OxCjBDD+6UW4/e9D+smeaSqxgfuNM4xkIm9JkWAaZ?=
 =?us-ascii?Q?MPvTu6cGy/wqJ1MhEsK/1KNUIuPZT2ATy6q5Mgunnvj9kGIIBnQkuPY1QKW/?=
 =?us-ascii?Q?7q+mT8rwA1DYq+F8sLFkO+ye9xaAyCj8PIxINA8O4Buv1qkAq4QKBygqoN3+?=
 =?us-ascii?Q?hK5EkghPXw+TwedQSujNkatH//6QMhyeh1TzfnSVhNPTDRBy5zp0/jmPPgRf?=
 =?us-ascii?Q?O2Ypl/TU7CJGgqh7Pp7g/aFfxg9cajFTHFwt1R+b2lleAdH46aB/ypfYpO4D?=
 =?us-ascii?Q?0gSfzdGsMgQ9ENXL4LNUeOMj+B0QmzX3hX7sT6OVeAyirb+GCCxdwM+JTfB4?=
 =?us-ascii?Q?bxoxk92kpkgZxrZCTKzdjSqEQziS8PgzPU95tCuX8lxUVOeSm88WBBMCjUUa?=
 =?us-ascii?Q?KAh7YBt3134xNfpgFrNwPdKnMGSEpqHB960lsKF5XJpSAjZ3nkt3Zg8+h8F9?=
 =?us-ascii?Q?75U0/3qd7Aj3FuX6sRC1D7LjDpgTmqOo+3IjfikP/EAijudxw2NAjqlQIu/8?=
 =?us-ascii?Q?vIf8BQF/7Qq7a79ZWYisBr2uUQZ+uFwAd3Y7cXPzyF+Y1YrWIz7iCwOPKzUJ?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?JARnJnYzP1BwEsUFP7iV96gQdwx4w+qyffEb+lXadv9Lo/o/pR/IKy4IlCWr?=
 =?us-ascii?Q?21+oaH6VMb42fWveiueIWF4p9YqWyrF8R6CFt9XKDvo7Ulk2h0MW+QU8oD/R?=
 =?us-ascii?Q?R+94I9lrynnY9t4n5n7W9b8x3s9SZF4k2jmw0tXPlVqXKZz/NlPa7GYO6og1?=
 =?us-ascii?Q?Tfjyg2kZ0KP2T8/Ui+9ntg0zfAxyHUX4s72lQIwu+RtPcBytntDrXT0g3lYJ?=
 =?us-ascii?Q?qRqWMB3ltfsLLqD6CNeX9ND+O8p5cw1ae6Cneo2a0SsnMWqhcZBIQ5CEkYsf?=
 =?us-ascii?Q?Z7NezFMWUDc9Xat9dV4zPLNALx8enUVPfXcf6B6FglI+W9rVT94IHBawGGRJ?=
 =?us-ascii?Q?vHAd9fE+wTjtICfxgJ0fbf31cmXgkxioN0dSWpPJssmUMnGcqQD7rv8HJeL5?=
 =?us-ascii?Q?XOrc6sgTQDuZBOYSi2XzwMMtn/wZKyTrsGrWKkhKy5AWtmQDH+EZLl76MEyP?=
 =?us-ascii?Q?4L971ajEKoY13Gp7fkYEEDQqWSN/c7IkPOggsOusDKbnxFFaUNB/XsMbdRU7?=
 =?us-ascii?Q?tdfpYYaL0c8teHjH/h++0kWF6l6TlS12tCPuO3UFZPukT6db8dzCTWzlgXSt?=
 =?us-ascii?Q?T3rhE2WAb5gQ1OVHjDCEfgVC4SAPVJhFMySFL5OYakto+yn6MP7gPJYOmWlP?=
 =?us-ascii?Q?f1l2j/LlHPXI9qU9/yKKWw5P4qHtbLekIOTq+QieUnm5vnKed+686cVdimxX?=
 =?us-ascii?Q?+1Xe1DI+LDxLXnU66lEkmboWkNpbWo7jSkQK9HwrZvU3tZbq5f5B8+3921PE?=
 =?us-ascii?Q?wYjl6tuCnM7i3Jqu06r0nXyusTJpKhu/hSiZgv4Dj2o1Seye6I5eL6B0eZ1W?=
 =?us-ascii?Q?YzvYWbB3U8u3Rvy/rLx30QqgTLCsEPPpAshPC51BZUg28qqTDcFSEXTXjRPf?=
 =?us-ascii?Q?od+KUwGl86EFAHK+aQyAeAxQMsQVV8G1YNa6yVzNbZA81VZZZRYP0ORj52Kv?=
 =?us-ascii?Q?WFrR+gQnDutZzbOvfPjLAwYQ7Nvz8Y3oOHI80rL+eWOuSjfDZWaDbi16km84?=
 =?us-ascii?Q?Gf4DcKWRSElnnpwz9U0FpYHgFpuBOrhXiluF22y86O9fd3pYlfYnKSWW32zE?=
 =?us-ascii?Q?HL7RvRFthOSKpt20xTTaXbtEDsWTHA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3dde887-7db9-403d-44d0-08dbc0d6c81b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 10:28:11.7002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fgWKZOfdmunQGsQsmQsLhXZDFNxCoD8NbRHDAToBfWMj5l4CgxG450mr3+OqSIbQHBEDZTtdvBLVbXDuGuCFQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6153
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_08,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290089
X-Proofpoint-GUID: dafVnUl1F-EIX_RZaatTlGJI4LOmzBAH
X-Proofpoint-ORIG-GUID: dafVnUl1F-EIX_RZaatTlGJI4LOmzBAH
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently an IO size is limited to the request_queue limits max_sectors.
Limit the size for an atomic write to queue limit atomic_write_max_sectors
value.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
note: atomic_write_max_sectors should prob be limited to max_sectors,
      which it isn't
 block/blk-merge.c | 12 +++++++++++-
 block/blk.h       |  3 +++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 0ccc251e22ff..8d4de9253fe9 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -171,7 +171,17 @@ static inline unsigned get_max_io_size(struct bio *bio,
 {
 	unsigned pbs = lim->physical_block_size >> SECTOR_SHIFT;
 	unsigned lbs = lim->logical_block_size >> SECTOR_SHIFT;
-	unsigned max_sectors = lim->max_sectors, start, end;
+	unsigned max_sectors, start, end;
+
+	/*
+	 * We ignore lim->max_sectors for atomic writes simply because
+	 * it may less than bio->write_atomic_unit, which we cannot
+	 * tolerate.
+	 */
+	if (bio->bi_opf & REQ_ATOMIC)
+		max_sectors = lim->atomic_write_max_sectors;
+	else
+		max_sectors = lim->max_sectors;
 
 	if (lim->chunk_sectors) {
 		max_sectors = min(max_sectors,
diff --git a/block/blk.h b/block/blk.h
index 94e330e9c853..6f6cd5b1830a 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -178,6 +178,9 @@ static inline unsigned int blk_queue_get_max_sectors(struct request *rq)
 	if (unlikely(op == REQ_OP_WRITE_ZEROES))
 		return q->limits.max_write_zeroes_sectors;
 
+	if (rq->cmd_flags & REQ_ATOMIC)
+		return q->limits.atomic_write_max_sectors;
+
 	return q->limits.max_sectors;
 }
 
-- 
2.31.1

