Return-Path: <linux-fsdevel+bounces-5971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0625811891
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 17:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE2B5282674
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 16:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9274A31738;
	Wed, 13 Dec 2023 16:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J7JKHtQH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qnpuFuiB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12516AC;
	Wed, 13 Dec 2023 08:03:19 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDER4TW005757;
	Wed, 13 Dec 2023 16:02:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=QMH+2lYAr1VOszWiieOpoWbNOEO7Nytnld9UWOXp3hg=;
 b=J7JKHtQHKCenCsaivqkWeebkosbKYZD8FsmUiz7zrULx/AptViKwnkBrG//jvruOFTia
 imWVDZj+Q37532+4KPOTKk4ziD743bn9GRUrRXV7TxUIvBdCDzlYvbS8UggdZw6QVl6+
 4PqugibpQueKtz+Wpng4Hd9YCKktzkHaSpvcrHNwQnQmUqEWWYK26OuLJkdisoaIJvYg
 ak+ACtmQCdiak8mAW2tUXea8j/PGPhlqjxEOlIdgRxGNsGLydnww0IhYXko0tHtss4xk
 rCwwAjHvrx55nQksc1X3DJHt5/oHS8IRBDQFWXo2vCGdVghiVu4xZfo5R936H3jN3EZn Rg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvg9d8nvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 16:02:44 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDFMY78009876;
	Wed, 13 Dec 2023 16:02:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep8g8gg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 16:02:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6MVRmplgVqTyTgPldpznbGEM3wFnInAcAejq9c786WIjz2iLc6oUkaZAfwykEpY2/tKj6bCRcHkhxiXg1WzqgipRA6yrQz6nmN5a/aw8fvTXOBgUenzBGGQjz9zrGHkB8/t80GuvqbLsdc3yJv4+ANbvWT7WOOiITw37k8qyit7QBmLKdpYeqCzPMx6ZtAqj0u75x3bp3m5x1uOdP0E64RBaYhVFiaVvhc5LqFVLqxeDAskOFKMYgZmzK0LX+auNfPAJSvoXv0iLAy/PNNZjYFjGCQGPkmBNwbO8v0vJoWdzYS8P0iVSjZOU0PTmIEGvrNzkrNevJrNo8Z91uydOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMH+2lYAr1VOszWiieOpoWbNOEO7Nytnld9UWOXp3hg=;
 b=a+otl/P0dtIIIqhVL9o6rkMC7wjp77VxiJ7jqm1enDWOA6nZpGz6JAhMYcp673FQm2Q0ou+LpIXrLA2O0Zy0AIJJtKvbvzLEBwPmTG1XvH2bWU5upiezkQBKaQwsXgqsjkqStEUlkO6kDQ1FaVustzqtgINbPFWkQKBCQdWpmxzDBEJoZBCVj3bfeLc6utKyETiuXmmSpsQjYI1c99vtEewB7n8deMl+i2sGUTHf4J8jBNJFDqlKwFDBxsB1RwU/U8DDCA/S/QQAue311t8mYJo7s3/oPsBp6gtGZt9trCYMf1pxhNiqMAMWkuDTXgDXB5Ygc+ZaOdLxBvioZh0a7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMH+2lYAr1VOszWiieOpoWbNOEO7Nytnld9UWOXp3hg=;
 b=qnpuFuiB3E2KX2nFze9ekSf+GS5X4MEJfILMk0kg1c6uTs6iklLpNvslJepzIPdF4XI9wz9ClJInNlIlWkVY0uDMinxE+izfmmr1UEE8WJ1PYCk1K7gtVljoOXPBsmivzemmKwY903F3hVJd2Sv2QNBtFjV7azKuNUwl5rtaVm8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6895.namprd10.prod.outlook.com (2603:10b6:8:131::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 16:02:40 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 16:02:40 +0000
Message-ID: <63debea9-4329-4e0c-a028-ad9233f13b64@oracle.com>
Date: Wed, 13 Dec 2023 16:02:35 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/16] fs: Add RWF_ATOMIC and IOCB_ATOMIC flags for
 atomic write support
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        brauner@kernel.org, dchinner@redhat.com, jack@suse.cz,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-scsi@vger.kernel.org, ming.lei@redhat.com, jaswin@linux.ibm.com,
        bvanassche@acm.org, Prasad Singamsetty <prasad.singamsetty@oracle.com>
References: <20231212110844.19698-1-john.g.garry@oracle.com>
 <20231212110844.19698-6-john.g.garry@oracle.com>
 <20231213133110.GL1674809@ZenIV>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231213133110.GL1674809@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0197.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::22) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: 87c6f73d-14e5-41fb-2790-08dbfbf4ef0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	iddWCB+c5tl6asuezilff1mKk3VFsI+jegNII67eHqN/nQCJZiR42lHL6TU0qbhnioI1lOmKKWdDHxmB+MoQLBpXaMKYsmC2MWOY5xFleqe/CeeNqR4hCdfu/7OHgbzG5xrsib+kPGbX7QIsTMMWIQXzbZpBUuzJlLkd4V2xHUpnvesKZvRZBEQLSIWsxnykKOGDb5xXbwzUpx6ldX9eNLjQr/wygyBuOn7Aaj5Q9BW/Ga893S9vaqeCOArCnW+KKxe03f3E8FkPqRUZWcUP5dPh09JOPfLnRmp3IyyoemrYsm6t37S8oyo6AFnQb4Gn0fKw6AeE8cYWtxcusRmH/SEdMR4Twoorko+CyBJ62AqkPy7dxlPfL4lDbhBDBFwxT/SoneKfBDL8tJVUhCYus2JXuC9TGqQ3ELG7vNHUAiVXiYiA8zETnxqaJN0NmPsiMCNj30rJXgv+PXEMGTz+l63gNZ++tkeqn0q9TzWNOZLBDAJykbAFAs9BUgUWVbIrkjh2f2K4DEXNG8aF9zS8anuNUhcUdXMF/uig3KLimY1cP4puEK5QoEEIzCRqfHKXNj2PipRoomoQYH6lROsY685HNiQdrp6XDX2MZC9NUwOZ+m9855BuZw7tspQygg61E7AepPDnMHNxVldMNyxBIg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(6512007)(6506007)(53546011)(5660300002)(26005)(2616005)(107886003)(36756003)(6486002)(66946007)(66556008)(7416002)(66476007)(6916009)(2906002)(83380400001)(31686004)(41300700001)(86362001)(478600001)(36916002)(8936002)(8676002)(4326008)(31696002)(6666004)(316002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MWVqWmtnajg0MGVPckduS3dwMWh4N2NBM1Nwc0JzNys5emwyRjBLSWpxVmhY?=
 =?utf-8?B?Z0hpbDlnamYrZU9KbkJpbDc5dW96MkpndENOdUtUb0x0cFg4VXI0YUxPVGNC?=
 =?utf-8?B?WXJtb2JMWDBBMG1DUXNyOUVyQzZ1cWI3VVFJbzNOQmVGb2pLWmMzTFNVako5?=
 =?utf-8?B?NDFLWXZvNkFhQ29kZlprN2ZEYlZERUovYVVVTFRmc0NwKzRQL2haOW15Y2s5?=
 =?utf-8?B?dmdoYUQ4QS80RW9vZjVGaUdubEhpbXkxWS9lRzNDejJEWHlTbm5hMFJNMFYv?=
 =?utf-8?B?UmgzMEdIeXZtcTFmcFZmMDl4RElTeTUweXZNTk01eWNpejN6ajd6a2E3dXZp?=
 =?utf-8?B?OGxKTG8yc2dBWXc1VmxacVlyR2NIcTZoUjBwbzVZcmFabWljdGFqdC9Uc01h?=
 =?utf-8?B?MlF5YmdyRlUxWVFqektCQVFNdkc0NFMzWld6WmM2QWdZa2lCMWZaUFEvMzdQ?=
 =?utf-8?B?OTBQTFMzenZWWUpVQlJnUGdGNytKc3BKNVcrM0dFb0M1TDVuSk8yVUFWQVNC?=
 =?utf-8?B?bkRzWUFtNnZuc1dvMkZoaVVhbWM1UmwzVDFFQm9Vd2FEWWN0cVJ6b1pDU09E?=
 =?utf-8?B?MHVuc2RMcFdXY0xKa25HYklubXMzeFliaVd0YjBBVDJzbENsNWFlSmErSkZm?=
 =?utf-8?B?VWZuQjF6a2M2NTVDMDB5ZExVODF1SHlxSnVnY1ZvenpweFBxdWhyRWFsenV5?=
 =?utf-8?B?eFlLU20yQklqNDdQaEVUb3dyRTUwaExVbExGVDBSdnExdTJlWTNMR1VDS2JY?=
 =?utf-8?B?Zm9uTGUyNXZPck1uTUczVXRSQ1JVTzB5dXVXQ01VWkx6R0hVNFJxdGZVdlhL?=
 =?utf-8?B?dVBrVmFFWjl4YnVKb1BOcHcvVzVGWmNoOHpZeGtqOTNNcFpablZ3VlNOc0E5?=
 =?utf-8?B?Z2ZDT3B0RzlWT1RiZE94TlpMcFQ0eE9CQzFXRnNsS2FHT1ZGaTRCcVpiVjNt?=
 =?utf-8?B?cUdxUUxTNFNseUtuRjI5U3ZYdDJDSlNqRnlSeWdsT2dHNzZvQVM0cnhqa2hs?=
 =?utf-8?B?NFE3djlXeHNKazc4TVJDV0hiQlJxSFUvdThqalB5QUxJNzlycjlkTS9ESkZr?=
 =?utf-8?B?cUlPR3hseHNHUFVDWHNQa2xYclNweFNaNXJndDZhVFFlZmFVb1dUanJiK2ZT?=
 =?utf-8?B?L1ZKZTFmKzFDQ1VyUHdYMEVLYXlNWFRuSTc0elBxa253bkM3cUdzY1o5MnlZ?=
 =?utf-8?B?WnFJZGJFZ0V0V29lWmhDYWFUdU5jYXBjUktMSEo4dVZSRzZNdmhiMldXSkFa?=
 =?utf-8?B?M1pDUnpWWThmbG9peXVRNHhLOXZCMVhnaEExYVhVUVpidm1VNDVNelVpZ1p3?=
 =?utf-8?B?SDVUUlEzenQ1MmlKWk43enhrMTQzUUd4dlQ2WCt1VjgyaEhDWk1mTWlOeHJm?=
 =?utf-8?B?aTM1RXlHR1NTRGdvdzUxRzRFRHpWZXVBZ0g5MHBnN2RWbG42NjQzTC9hRUpx?=
 =?utf-8?B?S3R3SmU0YkJtTC9UYWNDSzVzYjd1RlZwVWJ2bkxWbWtkQlVZZmpkZUdOeUhG?=
 =?utf-8?B?ZDExVnBLb1ZxL3lxc1kvVjI4WmpoclExNUFvbEo3aXlsNWRSM2Z1Rmh2SGVV?=
 =?utf-8?B?dXZrU04ySk1WRmt6WWxkamlpOXFGZ3NkV2NiRGhYSlhKVnJQeEY4cWpSNzJw?=
 =?utf-8?B?bGlSSGJkS003R2lPRVJuSWdoR3M5UWdRN3FDTmhIY2xBT3ZjdzAramVtTG1j?=
 =?utf-8?B?Y3ZvRjNXbWE5RkNRVDRwV0R4Y21jNzBWY2I1c2ZSWlAwbk1kaE9uZmt6N05i?=
 =?utf-8?B?VWFyM3FlbkNkVHBndDdIK2dFb3B4eE1wbXZ1MlNXVmJEZWorTnVNMnlPMC82?=
 =?utf-8?B?U3lxVDdObnJjRzhUSnZNRUJGTG5pNDNKb3UwVVBCbUM2eU9RU2RMbmNCSzhm?=
 =?utf-8?B?MVYzaDFtWW5SOUVvTW9waUNjQ2FUb0hzM0tvVGUzRU5nZDdyc2dZbFVkRGdG?=
 =?utf-8?B?TlllamtEcFhJRWJLdHpkVHNIeHVzdDNNaVBzcGFpWWdrR1FWNndTUUdUUWx5?=
 =?utf-8?B?elJjQXlKVFl2TDVmd1JYbDhnN3Vxb2dZc0o0eHVjNm5ENWk4SHZ1U01NWVNF?=
 =?utf-8?B?YW15Tlg0M1l5MVVldzlidHkrMFg0ckFZUWlkOXNab21KNmRKMVJJOHNoWjR5?=
 =?utf-8?B?MU1WbnY5QXFxK05UK3dIaTU2czhMMnZWSDdHeS96RG5RcERxdVVEY1JpaTZP?=
 =?utf-8?B?UUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?MUlyQVBkRWVTZ0ZoUTZJd0dOTCtlWmJpTCtVWXc0YUlOWmE2dUh3bUM4ajV1?=
 =?utf-8?B?QTVGZ2tRMjc2N1pCUDhUTDRzYTlmb3V6dmUwSWMzK01IM2JpYUpSZEVFUXpD?=
 =?utf-8?B?b0tPa056NTV5a1pPTDJ5dVhwZnRuNkdlNlh6YzRidS92T2dmbzdoUDZuSG1P?=
 =?utf-8?B?bktZaWgrelVpTlZRS0J6NWcwSEkrTFE2UFo5THNNRkpsZjl1U1FjVmlSaXRp?=
 =?utf-8?B?ODgzT01nU04wV2tFcE14T3Y5S1pMV2dGNzFDQzVJZkpIU0JOZHNLK204aE5o?=
 =?utf-8?B?T0xHeHNNMG10WDJPcHUrTTJERXBJNTA0VHJGcTFDVldzaHRGWHUxc2J0QVNC?=
 =?utf-8?B?TkVwQjYzeEZxRStpZVBvd2dqL0xVUWpQd1JvbkdwQ2VHcGQ4NDhXWDAvNW1I?=
 =?utf-8?B?L3hKQkl1KzdHb3ErM1IxV3dNVHlqTU1xOEVxRDFuK2NLOU1haisrejlLdStF?=
 =?utf-8?B?ZXZCTlJhSG1GZHFqYjZQMXVVQ2dlbTVmaU9FbmJNTlRVdkdzR0RSTkh1Ylky?=
 =?utf-8?B?andGZGtWZm9kS3B6TE0xaVY3V0tUVUl1K1JJb21LNHBVSDAraUYwTys3NEw0?=
 =?utf-8?B?TnVUc0lZSkJUOHRsK1hWa0lSd0VQdWtLNFFwRFU0YjMvRkw0WGl6RmJncXRr?=
 =?utf-8?B?T3l2UEZ5dzEwMUNzazdSVWQxS1BVblVUT3o0SSthUWRWR1pVRmtqa1ZtR0pl?=
 =?utf-8?B?WHZOelg1WkZhU3ZGNFFxZE0rMXJkWlFRU3lNSnlPR2xYUHJ1eEhQMGl4NGRh?=
 =?utf-8?B?bVIwY2x0RlFhS3pmN1o3cm5hMmVMcXVsT0tUSU95ZnlYeWlOVmtVWDZZTGJK?=
 =?utf-8?B?ZSsybzhtSlcyRFNuUC9wM0lxRW5Fam9xZFZvNDl2dzF4L2JEc0Z0QysySjZq?=
 =?utf-8?B?TE9TOVlBV0VzdGtEaE52VEtJaXdFS2ZwQVRpU1ZVRE9tRkp0UGFEWEdIVHkv?=
 =?utf-8?B?MnFsTEJTLzAxOE5tSzlJMlpreldWSG1QVXpIK0RrVkVkTU5JdGxLS1ZGVTk2?=
 =?utf-8?B?R1lQZzdqVEdmcVE3N085SEVSVHJsV3A1Nm8zb1laWWZacTdDa3ZzaGhwK2xM?=
 =?utf-8?B?SEZjSWRVbW9ZMVJPME1RVHRrczdzdE1OMVNaeEVlam5sRUpuTHhBZ2szVWMw?=
 =?utf-8?B?RTBJbllBTG9jM1g1Q2EzbXJENGovWXdFMkNuMnpvaFk1ZEdvSTZZWUh1enFj?=
 =?utf-8?B?WmxVRVpsNXNUM3c5SlBHUUJlaXpMdk1OK2E3S0ZiR2d3aitMbGNQcEF1c3JO?=
 =?utf-8?B?N0ppdHpDUXl4TGZBN0RTRTMwZHZQU3FNaTNoUGdvOUlZVEg1VTFHSjIvdVEv?=
 =?utf-8?B?Y0xyOGZBTUtoVjh3UDlSY25CNEdZbGNwSTVrbkhLekZJY1Z2MHZadnF4NnE3?=
 =?utf-8?B?RFJtZWY5MTJoZC90YTZlZ2RtTDAwSHZrbGo0V2FtK1NxaWRHUTduK0gwR1dE?=
 =?utf-8?B?cWtrcWJTTHhvRVpCRVp6WHN0eWJzSWpjVHp1QXU0RW1CaVNmREFDS2g0TitH?=
 =?utf-8?Q?w00rEfGndksoC0mg1PbVa7yfulC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c6f73d-14e5-41fb-2790-08dbfbf4ef0b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 16:02:40.7464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Migkg1mZXN7avobHaOhTr4ADnt/llIW4/fuB0srxWOyQcIqgw3zfmSPZdTIj+cBIEGnWkuxEh6PuG4Uzk6z4XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_09,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312130113
X-Proofpoint-GUID: 5cnQBkZG4Gc4Ip7h2IIdFsxpTfNilV2K
X-Proofpoint-ORIG-GUID: 5cnQBkZG4Gc4Ip7h2IIdFsxpTfNilV2K

On 13/12/2023 13:31, Al Viro wrote:
>> Add file mode flag FMODE_CAN_ATOMIC_WRITE, so files which do not have the
>> flag set will have RWF_ATOMIC rejected and not just ignored.
>>
>> Signed-off-by: Prasad Singamsetty<prasad.singamsetty@oracle.com>
>> Signed-off-by: John Garry<john.g.garry@oracle.com>
>> ---
>>   include/linux/fs.h      | 8 ++++++++
>>   include/uapi/linux/fs.h | 5 ++++-
>>   2 files changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index 70329c81be31..d725c194243c 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -185,6 +185,9 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
>>   /* File supports async nowait buffered writes */
>>   #define FMODE_BUF_WASYNC	((__force fmode_t)0x80000000)
>>   
>> +/* File supports atomic writes */
>> +#define FMODE_CAN_ATOMIC_WRITE	((__force fmode_t)0x100000000)
> Have you even tried to compile that on e.g. arm?

i386 and now arm32, and no grumblings.

I think that the issue is that we only ever do a bitwise OR or test that 
bit 33 for a 32b value, and it is a void operation and ignored.

However if I have file.f_mode = FMODE_CAN_ATOMIC_WRITE and compile for 
arm32, then it complains.

