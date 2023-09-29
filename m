Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861FC7B3083
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 12:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbjI2Kdc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 06:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbjI2KdE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:33:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0120E1BD0;
        Fri, 29 Sep 2023 03:31:29 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SK9bcZ023115;
        Fri, 29 Sep 2023 10:28:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=TWL9VW7+Cjx1OP5x8XjpFmdVa1NlzbdA8NRlY5je9dM=;
 b=gVR+f0kZqers/sAulFwvz0PUuhSwPDfhVfOojsyQ3rXJaHTpWQhqalAE68mDBjf8I1+A
 rYhttKZsAW8DPoIXkFOkbrETCMj0HnnNfp1gt5QXh3LGmqInuqKZpqJ8PueFRr3P932+
 vy4wY9HySkS1deloNangfBo0DqvLmfJILeVzGl62ivHjkBBDhHzU16X6K8tX4+xRuC5u
 QxYsdVL8Ty4HtJQ+S0QHciNJfR18EhgRG5r5EuCu4rXj/xp+G3vPIHPEsjTNKQeyKiQN
 AP33BJ1gj/TJ3sn1AWSBkNCWPBcOPgOz6lWdOL+klWm84FKmOiGkfKvjST6vitseBJNt 5w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pxc6k5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 10:28:44 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38T9iSO8015821;
        Fri, 29 Sep 2023 10:28:43 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfh4vtc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 10:28:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHtID17+bk1sW49hYXUtVcMsbBFYBNg4hYvHIGNahjmnaKF2hTzsliQOshdoJ42f8qWYHqCI7MlZgQk0i/roYSdXB06XZacroeyDDh2mwEfle9Me7CiN/i976J/7xBfbufPkILnVPMDc64fXi74epU/A6Fw0Sm5GD/B1yYB5NaOgLxl5HHzNai3Hp0MFdiZc55WwwXZbtcazzvRFuVD8WfTBeLh9+xS3YlXZafP8kXr6s5JNtOpD2m/iLODw7ueVqgkyuUOLYl4p4BghrfSAslEWsDejZ5oMjgiphmH/NcY28J23edo/FAKzQQCycdWPDT2qaLew0XqmxWgA1uSZ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWL9VW7+Cjx1OP5x8XjpFmdVa1NlzbdA8NRlY5je9dM=;
 b=ZGQOCkj7FSISfVVCGrAsTQjxXFLhEF6nN5clzaL5Of96eb+yXjCgPmE4B+Fhgerd0qK3KyMFF+TfzkIkNSwCNNO+g6Iytek9qLa+ARZGpePwqXeQO6CaDjkADV3jIyiOhNWrlFqJbhhqa/gEunX2I8CZZOuZxB4DeOLK9LuMsBMV8aEraXwPXD2ks7gcr2Hs2IclGWfuYwGEoz1J5GON1w1Wgn+y4+XmZDH3bpLsGXUScv9hh/ZjMIw4UATvKZvIOk4qB3ikMROl/sXeShTRC4TEH5hCdS7UyjHZLuHOs9mCJzRAeviOtJY4of6+MpTndl3yQE0hKZifAJWF6u5xdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWL9VW7+Cjx1OP5x8XjpFmdVa1NlzbdA8NRlY5je9dM=;
 b=kFxARJU+8cJvILv7FQcNY12hFQiSdOp5GAR6Z7ubGQGrgT14hdHAGLP2g438MDZbjW9fjUqJRh8yuSn4WPYu3SOcjhafbyV+kgcB35OCyXEFp7wzjINy3PL7Z0Wjx5YCtcup4J1Bdr65PwUEybK2P58H0Wkz3HI5hqWedX9UBLg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6153.namprd10.prod.outlook.com (2603:10b6:510:1f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 10:28:16 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 10:28:16 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 09/21] block: Add checks to merging of atomic writes
Date:   Fri, 29 Sep 2023 10:27:14 +0000
Message-Id: <20230929102726.2985188-10-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230929102726.2985188-1-john.g.garry@oracle.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0041.namprd07.prod.outlook.com
 (2603:10b6:510:e::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fd9ec22-ec02-4b7b-620d-08dbc0d6cb05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KvpDWj4J4csqDFax8cgqJgdFZdLjlbZSsdWzHQ/yWbcUf1NTcjKorAegdo/ix4jQHTDIznd5arHnqjn8z49sEWRlLgt2XO5FqyFkaPAYABs357v5brrkWIifvxi5D3EPVVze65QDhNgXPyax5bK0zi8Z6FORu5m+snmJNJZs4GQR2VfuwGezF4KkIhZFNACiWdhgw/ZCcB8OZsSsI7ievDSiItsVwz5owBd6wR59ntKT31M0Bdx4JTfmQ8QqfHPzDpn8CbYCCY9jPYF5IyZOEaczGD5gvMU/kHkNb/5tzfFFGf/OWy/QHx0YAiuqj7yVBLdcmKRj6IbjEgDuwWJevSY1mR2BG82QmX2kHKKoyo3yF85zU9EX1BBvUQoD0zA0wE/7AgjCZiqCuypdBwqYINE8toWptOU8WiOc9Zfw/MDknx0tw3pf8jUX1/9pBz3J4KzC122UimJQhds2/ARhY8VW35ny0ygDFVKLLSu71GRDTL8N/ViQASQVXQdtwDU6zzS8SrEpAhXeTapzb5TfS/V8h8e8Upf6+s/v6ctNOwqT+2IF/3CkDU1a7XnUZmGZ8DMzdnAYc8tW5z3Txqz1WepIgz3R0u1NFtQLTT2usLM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(376002)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6506007)(6512007)(921005)(107886003)(1076003)(26005)(2616005)(8936002)(4326008)(36756003)(103116003)(66556008)(7416002)(2906002)(5660300002)(41300700001)(66946007)(86362001)(316002)(8676002)(66476007)(478600001)(38100700002)(6486002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JmizjJCB4lR3jrdunbbTGVEyyIst7xgwZ1sUiV6EPKtHniNCHi5Qo9lFbdXV?=
 =?us-ascii?Q?HnPe1J+tCzaK9I6IFtsj7WnnEtDndWcFWPOBYT4LxQGwNuyeKDc4PgW0oWUA?=
 =?us-ascii?Q?DOuxLIDc+K0XYc24lsVqxB9PjAuLiyN+R4eQaKvTqLovxXtzTRz7+nIolATq?=
 =?us-ascii?Q?7GeVs37CeUtQsWXO4C5NFBjMKhCSyGxz5ZGmVf562V/iEtBE29X34LU10Q6C?=
 =?us-ascii?Q?+aKMmhk81MTFLeitGiclhdZ6pNjHvmrXZbc6LReGK3AiEk3ylaERqnsNlIag?=
 =?us-ascii?Q?2L76z/yf9ylMf4DCFyYLp93th8gJW1qKD7uL4E2JhZBOC8ngs3XQ4jLJXkkO?=
 =?us-ascii?Q?G9sje/iVaOFQoXeXxkrx9qqPi23hHSsLK2qfEvrEChVjZcFfFy5xhM0BtQ2/?=
 =?us-ascii?Q?UiDwqi046+UvTHWotruXybJ4LTR+wW073UKe+peBuz4/nV88Ksc5mV40A7LE?=
 =?us-ascii?Q?SGrfct+/hwAOQJ2SLzLub9k3Pnwn0JwMWIcflwUuok8UiuWGGtV7wYCexuQM?=
 =?us-ascii?Q?TaNQBU3S6Inlx+D6dn2lL0QknikYMgKect5Wr8TYuJxKmbsUM9LCQbmjmtuX?=
 =?us-ascii?Q?F0Abu9l0EiL/i1PQFgIA1TlsSW3n2ZKO9C+puazmIJHreIOJOmJ43EukMIHa?=
 =?us-ascii?Q?tRwbmByTgYOrat9PNKV4ZBpwyMOga6bNrbcuNcfyjJCCDSKVTsGxb7cld6Jn?=
 =?us-ascii?Q?7igh+GFiB91XUPbwrQrWVSFhhVcJRRgIRwynZxxFnk2OB4NqKbseDQLyAm+x?=
 =?us-ascii?Q?YL2yOb6sgKPAlWJgh0X3woXvX5vgUCf9PvlREJyOd8fGGXCKFlYFvcxV6pSx?=
 =?us-ascii?Q?RdO9ObmJTvOhskRd9gSNevQfzs2fZB4uOx5CYSe7Jsm3NOpDp64E6SPUyMbE?=
 =?us-ascii?Q?FrUtp69UAlJDUNwcuEACZAXuuaSoaNWowOoIaVcJmY3ZRGnNEzdrdhG7myi6?=
 =?us-ascii?Q?K507ltQeiaRHzKQSQxfPcXkjzNp8FXLhzKkduOeL7WDoYsKlJItlDk1q3jUI?=
 =?us-ascii?Q?IrToRmfzS9WvhACbiFYzxWvi3/ha5dmpon6Un0pW9NqLxV1PH+zqAOmN5qCq?=
 =?us-ascii?Q?svWgPS98xJX3x6sb99g9rc+47Tqfko8hec2LOXaxDhUtazMpXefUqgi7a14K?=
 =?us-ascii?Q?+IL0cckcOXloTufU73W5CaCTqqpYlUfXiAoGt9XJuCRRc2suwgWcsnRmmnR7?=
 =?us-ascii?Q?qpNB5L5JuTQu8LUmUsyDpR7P7W3I/H+PVm1Oc0dei3liQu8AlyEk28xumcS/?=
 =?us-ascii?Q?+93GOmgL8WtJThebrA091IH6JdsXkLE/RQRAeOZ+7wJNRjs8FEx233J3BgRo?=
 =?us-ascii?Q?S94b/vhJpN9kD2qSEt4kM0VK+GOYleWJoe9kCCnk2xjNxwO4fIa8et6X1K6C?=
 =?us-ascii?Q?LVDjiexPAg/pbSoJ2fDNVpsPJRD4oRulgVKPio1uvn09pBp5OIcqynP4cyLI?=
 =?us-ascii?Q?EUBkVZ4uh6HeSSEG4zLmxJ0/oL40XZv9QjMFUMQctqzoaZPNvX20MhTNjGvL?=
 =?us-ascii?Q?soVRXHZYjDXouA26lC0aIb8+0hNpcXD5Fi0sOIj00/1p3qfbWs7kimf9OQBu?=
 =?us-ascii?Q?e/FcwMhXVPKEBj9ZmLtDqEN6Pvtv4tNFRHMnKBaoIhk6FpTWsy2KpzTE3vSj?=
 =?us-ascii?Q?Hw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?dNfZbTihwY2tki9D7rgrHoqGES4H+VNpnPkfADiK03IRZDOcDoeygiantrIT?=
 =?us-ascii?Q?bugN1V5IkwfPzjsUmEEs0QqNd7KhwISu0TVFPm14ARdLBV31wF6PGmZsX3+N?=
 =?us-ascii?Q?jYD0a3ik4uQsFeO5PLaBSCDfCXjRlAesM+w4Cu1wNl+eaBj4OLLczRzH9bhA?=
 =?us-ascii?Q?2gVnNC6CMcoqdFo4Ic2OCwPLW4fuhoTw3Qy5TzzzxsnNLzrc+/a3A8tqQvpW?=
 =?us-ascii?Q?MCMq4AFnZZghK4ITUjC2ISz0sVG3Nx2sUThJS+v+Eevoo/aubCCaK45k/68P?=
 =?us-ascii?Q?dSRB4pTVFtt/OwvZooO0QQY7U5/BmkDmSU1KTEnPZ9tcolQmKlvuZCbbqxqH?=
 =?us-ascii?Q?55E9WehrNrvV0aSBP9xtuwNiGopiofAsXqOH9KaeYM9AgiZnS4C/E1WPoGpq?=
 =?us-ascii?Q?In+uEBwunFLw+ZWP5PgLULOAoqh0I3d+n5+XD7i0AXfpJiO/IYiDHC9RK6Ka?=
 =?us-ascii?Q?0lvcXeKNiPdmjG93nm2kF56oyGduO2ht4QGX5Ir0LkZo56x54Y2DH1ZfyQis?=
 =?us-ascii?Q?KaPvalqLY2JTT5lIj0Mb4EgO00h6tgfbmBYIDy5uv36/K+pDmZVM8mnAZYLj?=
 =?us-ascii?Q?tEno+foHw4HavYOSX9lOD35/7mad2Gw5GB9xLsKtAgx9lzD5WkJM1G+eSNLo?=
 =?us-ascii?Q?gaWE+r6bIA2ygUPsp5GIEqxct8C6NGr7Ocd9tVDhxIoEC+wwV/QtRxomVLnn?=
 =?us-ascii?Q?XKFq8t5CDVYzJ5FwSUziP5YhZNnTBSM4aSvRN7Q34Cap53X+q6AQW3lH51w0?=
 =?us-ascii?Q?35zTipO+uHyrJvOlOA0y9+6M+A3aMuSJdFSubxpAJsHfQ8KV4rfMoiWrXPyo?=
 =?us-ascii?Q?KgKp7wFG5Z9SFtwWWertRjqzfGKHZgm9kMVuyAv5kS00lLMIOfwUn3G5orLA?=
 =?us-ascii?Q?tML3WN+V2QiTcGOpdCXudnI6hOeYTlYnLQughhYKRQtgSQceIpZ2mfDFnpND?=
 =?us-ascii?Q?c2EaNqlxsVcI5icESiguKXqoF2E0O0EzVwKj9xhwrFbDVk+VMMKD34JLSk90?=
 =?us-ascii?Q?DRLT5kJa6Dk9DVPjj6ujUximZugFjme2WBimMtODmODPpQjZ0KW8nBZgWQsm?=
 =?us-ascii?Q?Ff5wtHQdbU8pHudsdl1/F5elzVao6A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd9ec22-ec02-4b7b-620d-08dbc0d6cb05
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 10:28:16.6204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eyBIF6xlNXXWy8Xq9iip+VQyC34EDK5XibbH75dqTXT1Nnb3jpr81VDhRhjcgwY//QN9oqGndgepjrWpesQA/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6153
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_08,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290090
X-Proofpoint-GUID: _c-p59VYDQUJh-xtoTn0YzrIewPbxDjV
X-Proofpoint-ORIG-GUID: _c-p59VYDQUJh-xtoTn0YzrIewPbxDjV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For atomic writes we allow merging, but we must adhere to some additional
rules:
- Only allow merging of atomic writes with other atomic writes
- Ensure that the merged IO would not cross an atomic write boundary, if
  any

We already ensure that we don't exceed the atomic writes size limit in
get_max_io_size().

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-merge.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index bc21f8ff4842..5dc850924e29 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -18,6 +18,23 @@
 #include "blk-rq-qos.h"
 #include "blk-throttle.h"
 
+static bool bio_straddles_atomic_write_boundary(loff_t bi_sector,
+				unsigned int bi_size,
+				unsigned int boundary)
+{
+	loff_t start = bi_sector << SECTOR_SHIFT;
+	loff_t end = start + bi_size;
+	loff_t start_mod = start % boundary;
+	loff_t end_mod = end % boundary;
+
+	if (end - start > boundary)
+		return true;
+	if ((start_mod > end_mod) && (start_mod && end_mod))
+		return true;
+
+	return false;
+}
+
 static inline void bio_get_first_bvec(struct bio *bio, struct bio_vec *bv)
 {
 	*bv = mp_bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
@@ -664,6 +681,18 @@ int ll_back_merge_fn(struct request *req, struct bio *bio, unsigned int nr_segs)
 		return 0;
 	}
 
+	if (req->cmd_flags & REQ_ATOMIC) {
+		unsigned int atomic_write_boundary_bytes =
+				queue_atomic_write_boundary_bytes(req->q);
+
+		if (atomic_write_boundary_bytes &&
+		    bio_straddles_atomic_write_boundary(req->__sector,
+				bio->bi_iter.bi_size + blk_rq_bytes(req),
+				atomic_write_boundary_bytes)) {
+			return 0;
+		}
+	}
+
 	return ll_new_hw_segment(req, bio, nr_segs);
 }
 
@@ -683,6 +712,19 @@ static int ll_front_merge_fn(struct request *req, struct bio *bio,
 		return 0;
 	}
 
+	if (req->cmd_flags & REQ_ATOMIC) {
+		unsigned int atomic_write_boundary_bytes =
+				queue_atomic_write_boundary_bytes(req->q);
+
+		if (atomic_write_boundary_bytes &&
+		    bio_straddles_atomic_write_boundary(
+				bio->bi_iter.bi_sector,
+				bio->bi_iter.bi_size + blk_rq_bytes(req),
+				atomic_write_boundary_bytes)) {
+			return 0;
+		}
+	}
+
 	return ll_new_hw_segment(req, bio, nr_segs);
 }
 
@@ -719,6 +761,18 @@ static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
 	    blk_rq_get_max_sectors(req, blk_rq_pos(req)))
 		return 0;
 
+	if (req->cmd_flags & REQ_ATOMIC) {
+		unsigned int atomic_write_boundary_bytes =
+				queue_atomic_write_boundary_bytes(req->q);
+
+		if (atomic_write_boundary_bytes &&
+		    bio_straddles_atomic_write_boundary(req->__sector,
+				blk_rq_bytes(req) + blk_rq_bytes(next),
+				atomic_write_boundary_bytes)) {
+			return 0;
+		}
+	}
+
 	total_phys_segments = req->nr_phys_segments + next->nr_phys_segments;
 	if (total_phys_segments > blk_rq_get_max_segments(req))
 		return 0;
@@ -814,6 +868,18 @@ static enum elv_merge blk_try_req_merge(struct request *req,
 	return ELEVATOR_NO_MERGE;
 }
 
+static bool blk_atomic_write_mergeable_rq_bio(struct request *rq,
+					      struct bio *bio)
+{
+	return (rq->cmd_flags & REQ_ATOMIC) == (bio->bi_opf & REQ_ATOMIC);
+}
+
+static bool blk_atomic_write_mergeable_rqs(struct request *rq,
+					   struct request *next)
+{
+	return (rq->cmd_flags & REQ_ATOMIC) == (next->cmd_flags & REQ_ATOMIC);
+}
+
 /*
  * For non-mq, this has to be called with the request spinlock acquired.
  * For mq with scheduling, the appropriate queue wide lock should be held.
@@ -833,6 +899,9 @@ static struct request *attempt_merge(struct request_queue *q,
 	if (req->ioprio != next->ioprio)
 		return NULL;
 
+	if (!blk_atomic_write_mergeable_rqs(req, next))
+		return NULL;
+
 	/*
 	 * If we are allowed to merge, then append bio list
 	 * from next to rq and release next. merge_requests_fn
@@ -960,6 +1029,9 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 	if (rq->ioprio != bio_prio(bio))
 		return false;
 
+	if (blk_atomic_write_mergeable_rq_bio(rq, bio) == false)
+		return false;
+
 	return true;
 }
 
-- 
2.31.1

