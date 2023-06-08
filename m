Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084F1727433
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 03:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbjFHBVB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 21:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjFHBU6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 21:20:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E2A269F;
        Wed,  7 Jun 2023 18:20:57 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357N5eOs017147;
        Thu, 8 Jun 2023 01:19:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=ZeTayBQmXEfkeiVK5cec74SvX2/0lEMAt3GDAZktehA=;
 b=RfkTx5PbHqMml3lxmSCAGlBn23jd4K5kA+A7Y+EFXCsLzZXpRm/qBw8XEbixxV5G0Xfv
 xC+uO8hyP+wUDorqrb19msPCarC/2zZWuW9NIvkckQ5JbrXa3v+Jw4ZeW+mCf+A3IpS3
 NnzL5+siV8IemqjDrQk9sAn+ubOy2b2aPQDSxO7G+0DHaPVv8Bb4/55+whQhusUhcJlB
 0Ei6rfV4z71z6dtYWrpKoVU2lpdFyLXUyww5gX6P6j/9xCwKppZz4u8884G0oso7KyNa
 JK9Bhu9pkLPUkzcKXk8l8b9qbaRp5CgsbjRvhNILscG3CAWZaRr9ybtZhJnaLjuUlfmr 4g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6pk5xv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 01:19:05 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 357N3h8o015848;
        Thu, 8 Jun 2023 01:19:04 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6mft83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 01:19:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Box2lcGY/NEP+MlCrEoz/0apYKh7IxjxtsismJ7YrBGA4KZMmYg6jtE32EC7mTLCdYJc4/RaMBUH1Iwg1xCGNv9HUR63d5uH/1PN5IUyzZVmR3c1Q0Wwh9qchNatAdHPYaX6I+RMMQtNO8G/rcvNM0h4pBF35/j2N5EkbumRykeeuHlJXEw9lJxqky9efM+gF6Ay82EKd76KY4piyu2ZjiYzhfRnU+MrqBBepWIQ60S28D028n3iJ7404iU2tKg9Sqj5z4knXFHx0EEH6xmp84SErYxkvnjh1dnRL9CyJDMRZ2LigZmnD54+Y0bHvgsICtKVzNQ+coJ4bPr5Xdkzaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZeTayBQmXEfkeiVK5cec74SvX2/0lEMAt3GDAZktehA=;
 b=K5oy+l4HyC41KFawB5SNq8PUtUek/fTeQx8BBqpJV7fv2qrZzBhKrvSor/upyxq9JmoYchS3t6YQjnfsRjGoEJ/3XSDfPg5aKpsRDJQCngsk8IsGVvVAnPGU2/i93Zv/uQStgg5+ka6T2mfBjzS7nMAk0WDTCtJTz/AsN/uozIze06m4stvm2VsHchrYjBbRYbPb2Yr1l+R3tIfoRU9mU9OKv8Vo1zHlrjt67rbIiFLQ1XxB1XE3MMCqKdXV9fa20kH33azPj1E/Dm3TMw7uzQcJxiPMGOaJIeDdfwb5UbxmG+Hj0DWhXjdJDfcrXBafcoD+FxFBljAhxoROPMT5Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZeTayBQmXEfkeiVK5cec74SvX2/0lEMAt3GDAZktehA=;
 b=r8q2uSCuGosarvUzp53nNCIUSP1nc28IYRqlejrS7JUgi/8qTVFRLp7EjLn8DOvb3U8qTdHLK1/Mih3iNHo7lvuH8I3CZwxM5ZiYnNpl4XyH825zVY0kG7grS5/1hI9Mfa2ue/KxDsiErFBlC7iGUYww+5V2ymM2n8mKVLjELck=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH0PR10MB5178.namprd10.prod.outlook.com (2603:10b6:610:dd::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 01:18:56 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 01:18:56 +0000
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>,
        Josef Bacik <josef@toxicpanda.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Coly Li <colyli@suse.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-um@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-btrfs@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 21/31] scsi: replace the fmode_t argument to ->sg_io_fn
 with a simple bool
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq11qim4uqa.fsf@ca-mkp.ca.oracle.com>
References: <20230606073950.225178-1-hch@lst.de>
        <20230606073950.225178-22-hch@lst.de>
Date:   Wed, 07 Jun 2023 21:18:46 -0400
In-Reply-To: <20230606073950.225178-22-hch@lst.de> (Christoph Hellwig's
        message of "Tue, 6 Jun 2023 09:39:40 +0200")
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0282.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::17) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH0PR10MB5178:EE_
X-MS-Office365-Filtering-Correlation-Id: 37bc9e3d-07b5-4fa0-8e96-08db67be54bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r5vJ01UBQvoxkQ3cbKqr9+CqKErDMy8fLZjoxasZ+e33E82E7qLoASeZP3Jf7u99djD4gpte2J+e7FXIkZKktVGnQLsNC+tl8R8ARGrpGgB/L9azG0uDeoaISsXRy2/BYQngOvWD+TTIV++LxTDYFLytKmF7ywz3D1VRn+2gLl640xb5oCWIGqtR0jkqJjd+HtbvHiAiiaZ3nAaOnWR+GNcR7PNJOgRkxPisNJm/+mj49b1vwaivotEdYXEUzEMcHRCVgOaCT83qPOx9sBpcAkv8Ml7t8GJf5uWP+dbS573KQKC7pA9U4BAv+3injpcglT554WP3CNoiMDO4SHidU8lEBiD7fN4AJkmgE2IlkgaF8evA2s0+GaAHnZhriW2YbZLVdylZ0N7oAl0skfhJrzaC+7XxZIsFi6wVi3Pm7sC6R4Ydnh/jPsunvBp6cs0nebTY9bRGqtekZBOXyn+NIt0x38jQc28b3JnAphQ+xctYZxj8MQL7hbLCHE8jgvmqnJSfjcBm8ZKEiJ8lf1brJuBavX0Z4ih9ZZriE5eRADd4mLHAQwqeW2DIkddfhhir
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199021)(41300700001)(8676002)(4326008)(66556008)(6916009)(66476007)(8936002)(66946007)(5660300002)(7416002)(316002)(54906003)(2906002)(478600001)(38100700002)(6512007)(186003)(6506007)(86362001)(26005)(36916002)(6486002)(6666004)(558084003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nnm2eAnNJVbXNkQcbF+FqLQAZvlsE50K7S0Zk11DwRWR2TGEndm760fwjGXf?=
 =?us-ascii?Q?mgqjH//BlqVTuWwXJoSeRSDkbZUp+gAK8k6wegOyeCUQufMH8opd+qIfrr9X?=
 =?us-ascii?Q?Lih/2aSRF3sifvjq2tmet5UccHciZbCu3b+b4xlblN3nYkpkm9fE09k9HhUx?=
 =?us-ascii?Q?2ecU7S1aAwV1XNGBB0goesbwodZslJ2piII+4AzqtuLkcIdpH/043a2PMR/G?=
 =?us-ascii?Q?4eki4b8dI0FZK/kRi3PH/mQMbsc6W/kR1vdjA6+1bo9EHiMITZTtl+vTLzzr?=
 =?us-ascii?Q?lry/8nzLJJAmX67UXll4ujT2p/Y2ysujubnrONe1i/dUv3bDnSb5W7bsde5O?=
 =?us-ascii?Q?vbERzuJoBVrI9boHG6gLayvnrGUyg+U111wZ/GUjOUYpBKjx+Il8ESd825nx?=
 =?us-ascii?Q?xJZczr8jCIpXMUQCD18alfwhAZ6ABg0zwaKwpcWphICm5fKi2jyOGBCJYQsr?=
 =?us-ascii?Q?2l8ComK2t9QAj0EFB+bNxXhvYqWjvlCn3vkCjgfY5CS8BUA9Dn6EDiVIT969?=
 =?us-ascii?Q?wO8CgYDdNJg4E9B+FcSryViQa+ZOB9j/XJo0BEtjGm8A0fCtswJPT3ogztgh?=
 =?us-ascii?Q?WeJCbyofe9yFDsSnjrGO+qHwxAcmJ7PUW4mNPdckQRAx2pYpFB+kjbWXkLHA?=
 =?us-ascii?Q?O+oD5gGhSWfMfJwXTeJADSwFCjF5ZCDcvSOS9hzhMiYY6quwINaMjKM+9qNq?=
 =?us-ascii?Q?m1blA4QMEiJ/Uijv2pJzQaJCJTJuyMxRueCSyw83g05ztykWEZ1YjY2PKbiO?=
 =?us-ascii?Q?kBXIwZcBo23mdKJsBD1K3gdb1BklWlT0Tgf2390kMknB2WEtGczCXDbhynXT?=
 =?us-ascii?Q?9DZrosDP81ginhQS+KLEfyJeeIB5az04IeGvccHRy1ewH02WFrjwq4s9QSLH?=
 =?us-ascii?Q?CsNS5T1cfCrw71fGBQrWGiOtVucEGHDGuKeRSQP6ybqXt1GBzwJrFuHTTWop?=
 =?us-ascii?Q?3HhNzXAPYo8UMbhNBDEnfybZ7t5ZSq7mZyS6qHTb+UMGc5QQSOKETXsyzEck?=
 =?us-ascii?Q?ToOtrsMLP8tFtUJfNDGnAbZ5q/uKXCJ8a3vbVgqh6p+Pe1pQz2TXsiwlUoTn?=
 =?us-ascii?Q?qIdcD0lLieF7/NyYSM8EhTMUmqNdPh1MnxXIjxof9y18zyH7sDViv+9qDtV7?=
 =?us-ascii?Q?zvKLbBmj5QlhGpyGSwY9bFpk8tIuMOZLtHKlRgyNd5IJIjxYZH/KGJusUsiX?=
 =?us-ascii?Q?n1IpcRm/tOyG5mROnbsC2JM/xF/WgKPxzjNwtFpR0e0YXx+aWTwjTt3C10Fj?=
 =?us-ascii?Q?Lwbb3cjyfImCJxQWkhCQKqwuT4fVmD4td8Uv5xx8zxsVtn60nV1zA2BG3jER?=
 =?us-ascii?Q?A4z03xSCmXmn4ol8eYQKSjXIyYNbDdhWVlYXsBT0C2TQ3wYbu49gd2SvuxHT?=
 =?us-ascii?Q?0uUTHArkJU5BR58IiWsmzQv4sXfPSB2bdXzN4ZNc7NJY6CcDIQIRGgk1QZVK?=
 =?us-ascii?Q?9AyZNtmlAWMkCnFhnfhLlz72zlnLQMQvb+jFXhq22V8csQOHYnmoEHNp9F7j?=
 =?us-ascii?Q?Zga6INXgc3rVQIq0F9ePihn1i2BAdMCxV1AGcihSPP5MdyCOpUt4Ma0EWQmI?=
 =?us-ascii?Q?WPvAbKB6e4VfMH0HXlCUe7pH3NGbWUG1TDQ+qvm5VhagszHfNtQQKhQc6TNR?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?NKrg+HjsIahvdj1/VHD2P/Y1o44gp/wcfcVQDWTS5/L3G0nX214S3yPMRosj?=
 =?us-ascii?Q?FNOcNuo7akB0MumP0kIQjkQNf37VfKCKFBICDq79OiVSv8WcSWhpS/O4btOI?=
 =?us-ascii?Q?FupNkQsnSon+HcaxGP83KAbwRi8Dc1ULBcvPAllCoO8bh8jiRXdY/NA8G9uR?=
 =?us-ascii?Q?524jsB/xErwEwD9FWWPYXYgektWx3KxO5IbMmDsjtuqNEzQJPD0A+rky67wW?=
 =?us-ascii?Q?nMY3aunLhP5wZA8zkFjb8zN5WGfX7QABdeZAFIpv15EWO63TzQihUOyH/Pf4?=
 =?us-ascii?Q?f+buN5jXbIzS3BgTAaur4uvJWQERpRcGUVNymc6iE1o0A6ZGsbb3EESJWgzS?=
 =?us-ascii?Q?hsk0EBtAWm0uV065iL5/GcWh6zFybhcj8VnfzYs8Bt4VC3+miwLiY+IYR3VL?=
 =?us-ascii?Q?HgiulBQzE8+75Cbqt9QEINzmuCBAzJ7jJcB3LPqla/ZB4AvMQ92x1rwxHxMv?=
 =?us-ascii?Q?cPnfYO0rYcj79sQABc6P1RO/Gb+pVpie7Ulh/7xrGyKGqFwX6OjvJ5S+Yi3k?=
 =?us-ascii?Q?2hyIad+3RaseX6wKWix+Vevn5t3PFz2hySBkzR8o9P4MKiJp53E/OSg1g4L5?=
 =?us-ascii?Q?S9Xu4NI5CLLvPaTP/lDvRgtnf832XYFjFykzMpyhNlKYRI8SqNI3YXZPoLvN?=
 =?us-ascii?Q?1acqggN0vizaCHMO/tlK0+P5DwHBMkz3/fZe/63J/Oag/YOrBK+zc6aC/Izb?=
 =?us-ascii?Q?qnZIpxKJhzk8hBGAeDj/tj+Iipt7+ytj60ZJQrTTtsgrQPeyE2/4CdQbcevF?=
 =?us-ascii?Q?sYL7rGJSjiiMOMjftS8FmfduWLuBR44lr4k+kSMQGiBQ01yxeOSLn2EXJP+6?=
 =?us-ascii?Q?TGSuT0Eet5Dca0f3T0IEmEEMeA0MVEuTGi6YNXK7LMdE8npSnOS0olIXjby7?=
 =?us-ascii?Q?oX8+9Ky0QAKRlhAZRmmdxyh3vn+UZkkSEQYjZe3cFVbVtEy3V/TR3pqp1fcS?=
 =?us-ascii?Q?/fhNtmdhdhEubvvyLqoeAwSBqWjE2K5JoiMfPB7Q+2PHREAk8uPCjGEu5nHx?=
 =?us-ascii?Q?pAsBSgSUbHuqrS+nCwoSz9tsSA4Mq3BUhm1gBNuKtQxEPDcOPEzdjTVi4i5m?=
 =?us-ascii?Q?rURL+813/mLF8B1Rw6CdlYWCrjRjjkrBpmwGnMMvnYF8V5Co5egNPxpyB5i9?=
 =?us-ascii?Q?DRS0lf+ksiVT1VI6wQhHL+0pH3Mq31e8fPUSOyoyX+7ow/FyHHk+n/t0ThWk?=
 =?us-ascii?Q?hRM0RllOrQJ/tgfHsXyieBGpdtzKLJTu8vVscdeftYECyIh+fiB6F2zA4vnM?=
 =?us-ascii?Q?zGOcFFcKmyX8r14QXXdyO+M8tABVBceuscT2cMwN7A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37bc9e3d-07b5-4fa0-8e96-08db67be54bf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 01:18:56.7300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MKKm+PJQPDKt8ZCDErCqtwLzWg8O+0JRmYIsPLC6p0p9Yp/DaUHOEl9QrwIDOW5cryc/jXuVQhYFzg80X2hHGg/zna3PepxWh4zFEjUwOJE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5178
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_13,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxlogscore=586 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306080008
X-Proofpoint-ORIG-GUID: TaScGZo-CrxEG8au8lYxCKW2rvQdrWKX
X-Proofpoint-GUID: TaScGZo-CrxEG8au8lYxCKW2rvQdrWKX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Christoph,

> Instead of passing a fmode_t and only checking it for FMODE_WRITE, pass
> a bool open_for_write to prepare for callers that won't have the fmode_t.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
