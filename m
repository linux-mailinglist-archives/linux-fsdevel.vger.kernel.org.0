Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63FF7B4FEE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 12:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236358AbjJBKLd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 06:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236346AbjJBKL0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 06:11:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F66B3;
        Mon,  2 Oct 2023 03:11:23 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3928XGWA004090;
        Mon, 2 Oct 2023 10:10:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=tzuLcMg6NEOrC1wSqxPNtfqjb+2gM5CaW09lKGmC+bU=;
 b=mhx/XTOXw5FgxjAKmflmKjpai1425pgIa88RhbMnQuJ4x7xCMGF7uA+PNLJnvNFJWw3V
 NKuwmxMvQ00IXyLWy9LzHk++QrKbVPEAhLucja1M51qenqMtAkvyXGKzNoELcvNs0zvQ
 QQVO0l1P0IDM2CGmabh1TxacBc8Ra/vbRtfDm9BJmG82dZ4eTxJKVqtHUXVhaDSjk3Tl
 tz8jEvIgiQfIur4d+ZDqZHqqEeAFcJQ4JU3Bq+urxqvm1YpnQOAUjaIIOmfouzREaWfn
 p9ERpPuq7e6eccUmYHvkSmmjGiMqvhQGcyUtd8PTMKsTokBrZZF92tE51HMAYYE9polZ uw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tea9226j7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Oct 2023 10:10:51 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3929XMn4024842;
        Mon, 2 Oct 2023 10:10:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea44kjrf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Oct 2023 10:10:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgHpz8Kl+S4vddRznhc6GfsT85XP6Vt9PIwfConpXnHhXcjvxen7zwA4iLys0dJJTkfcqO+eHtYR4tN81oqOWuaQ/Fyna1371qiz/8UTwNgFJ8vwQWnZkwjMTfQDuPNHbT4IQbF5PZ8Fs6hnLLYTnJtsihxOwCuExBhLSwW/0+TCWn1n1ZSa93zPCWjnmozxFw+XCnX5Ly6P4nKs95SyncxOIoEiQTxu0lLjf2c0joEkFYIQH2013GgeLnPjC388zprf7S4i3LTLAnGYSGnr+bCZcMj/qMOA0LuQJrwqCIRTJR67fUBMZ+k664DbDo6HD+3NDbYwNPR35fZwDVaHZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tzuLcMg6NEOrC1wSqxPNtfqjb+2gM5CaW09lKGmC+bU=;
 b=PfIRW0ih0+vL+9DtQTElCW3I2wTNMI2WgsHCuXOSsFEp0dEcDLqXs05fZ0qw67vXcrIgH3aW9XB0QIHUBiT8LqXo+/Oc7Z3AYvTr4bQSDli4PjZj6wLlnALA0UHq60xOxX+TphLZBI6afvRJ7+tEiGIYK8BJfVgfJ01fOr1OL4lrvHyGpoQX0pD7qbZ+VgrVshN50/HTYLN+iaKsonG2lr7qMO6Ln1X1woTTaJcZz3K3saiyH42N7RmWyTWxg3Mzyw7/drLvkY3sBlO8Yeunbb0f0q4WEa1lEMRgpdx6INDd0x1DPWDmfjzy2VN21XaJdy0d9UuXtZ5mjsxA/eveQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tzuLcMg6NEOrC1wSqxPNtfqjb+2gM5CaW09lKGmC+bU=;
 b=w91maGMKm8IrBFn5gTr3KmyofWTN9nyzo58b8wG6PVdvFyxp9v7OVIDa3v4pvoG5TLRLshjBhV6ZnTZ7/3gh78RGgVPgy0QAV+QfEaFjpteXImJqxSRkoZE1mttjLb1WvWoiNhdGPR76UqcpCWzgmjpw8DLq2+XR9FvM9V65dGo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BY5PR10MB4274.namprd10.prod.outlook.com (2603:10b6:a03:206::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Mon, 2 Oct
 2023 10:10:49 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6838.030; Mon, 2 Oct 2023
 10:10:48 +0000
Message-ID: <5d26fa3b-ec34-bc39-ecfe-4616a04977ca@oracle.com>
Date:   Mon, 2 Oct 2023 11:10:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 10/21] block: Add fops atomic write support
To:     Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-11-john.g.garry@oracle.com>
 <17ee1669-5830-4ead-888d-a6a4624b638a@acm.org>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <17ee1669-5830-4ead-888d-a6a4624b638a@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0046.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::34) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BY5PR10MB4274:EE_
X-MS-Office365-Filtering-Correlation-Id: b8669442-1318-4437-d5a5-08dbc32fd9a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t8xAJnHsuRCOd8RNIEeYoimelRKfDnASqVhvN9zPmiNTNqIei2gUJWF3aR0ODzxMTfK6FUB76IBWgrrJ9AekWkCk4+4iEcoeZwMUP/nKfdaOBxMzPq62cPOtLQRRb4JRGm3JT5YwZLv4PcTJoA/iU2vX10eYOmmYocFVbTHvoEHEvXVuj4LjdK1Gp1obEihreMI/ZNW7PuF77efmtNUZBqer0gRnJlx3IhN4ZwhKkwwIPX1PvsPBcj9p/iSBYKDeuszODKy+5q2WcoHGx1mUfMKOGEcTeS8x4JlapBS8OWml/EWzQ2yUptWvcFQr1spCSe8IAFWnO6hvpd3Owtr1GSV9byeZA1zeaou+sOhM10L1uvZy0FrGd5MJKy7aLpx3s99loyFgSD0lwzfRCJTb1pOXoFxOCJVRV8jFn5BdSSUYBs65x94vIfQnga7jv8uA8Vc1MOVpw3gmlZjLVb4v0BU1Hc4LKB1njR6iHxu1bAR6e8fAmbdzUfT85GOizCgIholk+PdhXOI8LR8HbARUGDEijjoYkP1+eRjYpjkOQBA3RBpIv/h1wOvJFvAlIX/LDND5Lirg+NMGH59KaSEFm9fqrNxWhCIHqujHH2sykY7Jkc142NkmraEwEcLrzTMXpmKbh9bNYPvXhIDb1PHiSGj9JxEf8lD8DWKJQGz9okY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(39860400002)(396003)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6512007)(36916002)(6486002)(6506007)(53546011)(2616005)(478600001)(83380400001)(6666004)(26005)(7416002)(2906002)(4326008)(5660300002)(66476007)(8936002)(316002)(8676002)(41300700001)(66556008)(66946007)(86362001)(36756003)(921005)(31696002)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anVoelhJMXhwcG05TzhlYmVDNG0vWlZZc0YwY29lazFNam1JSDVPK3NCNmVu?=
 =?utf-8?B?Wm5FVDBXcURsNzFuY052OUF3TGZMc0VEQ0w5cE8wSTBwTks5TXM1TllvZURK?=
 =?utf-8?B?RUxpQkkzZEJJSlEyWEc3Q1VVWjdiRW55d1M4ZDhtNkFUM2VzZGJCcGNhQjdt?=
 =?utf-8?B?WmEyMmtwV2hWMWpLcHlIa0piTEp5SzVuNHhmMTZUd3J4V1AweXdkMUZvL2F5?=
 =?utf-8?B?MHpURUN0Z2MybHZ4N3hPeG42V25Wa1VMSDNSU3lIb3JGZE9UcWFKMGNHeDFs?=
 =?utf-8?B?dUNVTVpxZmFiQ1dzeUlDclQvRCtTK0JxY3RGcXBMd2gxN2xRUWxrLzhkN2hG?=
 =?utf-8?B?VnZUcGNrQUM2aVFWekd6RGVwSCs5WC8rc3gyTm9sSWlxdGlnczNha1F5SVBX?=
 =?utf-8?B?c3paNjN2SXFPZTB1YzJ1eGp3YS9YVk1ETkJUeGVHYXpTNUFGNUlNL1JFaUZB?=
 =?utf-8?B?MGNsQXRTQUZGb3lWSW1aRGh6MllkYXdCMTVsYmROWXJDZGxEVktHRGhOR0Nr?=
 =?utf-8?B?NEFOMGJKWUc5TmZkRUczYk5QdnY4c0dybGlsTDJrNlRYcFpkS2RiN2gwNm1S?=
 =?utf-8?B?dHZEcCtYSmk2QVdpL3dIM1JCaGpNS2djeFBya1orS1dnNlVqWFhFeDBpWGJT?=
 =?utf-8?B?NjRaam9VVHFqYjBPMGN6Mk5GY29iSC9NMnJkUHg0UjJRQjZEbEZpT3A2ZGd0?=
 =?utf-8?B?cVVzeGR4bUdiNFpvYmxJQkY2ek1yWnpMTTB4NkNCSExDVGNkN1pkNFNyNHhH?=
 =?utf-8?B?RlJBUE5OZERpWlkvZ3pZYzNiRGlHOThyb1o4QnpyS1RnbnEvUllhVWVFTHI0?=
 =?utf-8?B?ZzBLWEt6aTR5eHpYTllyWFF1bDM1ZEdma0xNMlV1WEMvV092NzNzQ1kzMUNO?=
 =?utf-8?B?UEdPbnltNkoyd2dsQWZ0TGREeUFoSFBXeTlSSzJUNmdXcGlhQUlGRXVncUtZ?=
 =?utf-8?B?aC8zejNENFAweEVyc2k5cWV1QWN2YlVZTEZjeEJKVXlVRDRFVWV2THJWVFcv?=
 =?utf-8?B?c0dqS3MvaDhBTUU5MHN6alR5OVQxS0ZpTXhVR1I2WEFoMDJxaGNqWjNFVzZi?=
 =?utf-8?B?enhhV3FTMVlDd3RBeitaNVFRaFIwV0hwRjdLWERFT0VuNGdhMFdxeTkzQlYz?=
 =?utf-8?B?cC9yVFZKVTJrczhnNFkwTW5oajZwYmpxcUFRWU1ENFh4OW5kc0pWZkt0cFND?=
 =?utf-8?B?RldteDRRWmNEdTV2c25vdzZEdkgrU3FFRUZIMDV6SnhuUDZqSVlhMlNuNE9n?=
 =?utf-8?B?eG83WTVoa0UvQzhGNkNKcDJlN0ZmajNxUmdpMlpub3FEMHhSd3l2OGs2blQw?=
 =?utf-8?B?d1lIZzNNeUNmQlVCTnhoMjBsYmtwRWNmSlRVY2x5UHhSUWxlWUh4ZHNhSjUw?=
 =?utf-8?B?S2lDaElNcjd6T0xBdENZMGx5SUdTaHcwaUx3WDhrbXc5OGlRQ3FUeUlCVWtT?=
 =?utf-8?B?RXY2YUVQSUY5N1ZEQUI5Ry9FN2ZNMDZTSFJpZ1Y5SFYvWFlQeTZsY1N6cUU4?=
 =?utf-8?B?QUtNRlVXUFhncldCenFFWDI4c1BWRTg4dGxXRmI0dlNPSXB4MWd4MjRpcEMy?=
 =?utf-8?B?K0xkUGVndFdGOGxiWklDMnE1VmZsNHRPTlh5S2lwdm1OMFUwbDhmNjFTQ3N3?=
 =?utf-8?B?VllBNkozdjY4dWphcWhZK1VaRGp1NlY3OU1PVUQ1TmgzR1dnT2x5WUdJMGhj?=
 =?utf-8?B?U2x5ZjBMS0lSYzFEYUZvTWpaQi9Ock9GaTFlc2tSYnZubmF3SUZSTUtLSG5o?=
 =?utf-8?B?YmcxaHR0ZnU5a0xQZ2VPUUcwbHBBUENMbzNmUndRWXl2aHJHUXRuQ3B0OGw5?=
 =?utf-8?B?Zkswc0Y4TGpNeVRFenBuRmtEa3JUazhPekk3d2tTNEZjNTk4UFROL1pQNlk2?=
 =?utf-8?B?MTdPb2V3Q05RVjN1SGlNeStMK1BYYktEZkdoYWpyMDBxWW5IYkJtYmI5T0pS?=
 =?utf-8?B?YWZ6V1FMTnNmOWtDWkVMb2hXWDVFTXVQYUR3dHdHL2pWOHd2a3hBUVd0QWFS?=
 =?utf-8?B?b0t4S2s3WUVZS0hReElmSnIvbzgrUVFDRkh1MEpRY2E2ZkR0bE9jdnlldUZz?=
 =?utf-8?B?WGk4L0dXMzJnODZOTlU4UnJUSzVqVVdZcDNaZjZNdzdvQ0d5YUtiNzVNejZ1?=
 =?utf-8?Q?jMf05T2wGMTTq2mhMVKqH4oQv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?STlxZGxZZ2FzZWg5ZTd0YWFoMnRTSGg4OXpBZ2Y4RGhNYit6ZWJrUDM1Mjhx?=
 =?utf-8?B?bWpzOU1EUWtJNXVoTUg3L1hkVjdsZnFqbTl3cmhiYmRaWHlyR1hZaHBGRVJR?=
 =?utf-8?B?TW1RTENCOGRIMW1MREhDQ2puN0ZjZTVTZXVZcFQvcjFSNjhuUHJGbDlQaytF?=
 =?utf-8?B?VkVrdHNmU2JhWE4vK3V6TkxMT2ZMMEtUYkUrMVFiS0ZwYUkvbWtSOU1yR1Jh?=
 =?utf-8?B?Zk4vWlZ0d3VYMDBQekN0cmFWYk42MW5VcWRkbDZQTTcyRk43L1gwNDQ0Z0NN?=
 =?utf-8?B?aCsvMWpHOFowMGRxQ3hyaCsrbzBpenAxVXh3bHgxNUF5a2IxQVNKREY3Q3ht?=
 =?utf-8?B?M2xYTElnMlkxMzBjOTFtNW1oZmhDUkFrRi9oNTV6WjdxVWM5ODF0TDlEN2gy?=
 =?utf-8?B?VnNGOG5iME5zWXJ1Sm1qNUxGQTFEUzhCM1IxR2xiMEp6alEwQzIxcmtkSFZv?=
 =?utf-8?B?VzR4UDkrSENVRy9GbDZDQVRJZUpCRHEra0pYRmY1UXl5d2RTcHRoLzAzVkFZ?=
 =?utf-8?B?VkNqdTBlZ3JyWUh2NWlGcGU3SmFPT2pxZzVPUElPRXhsdTA2clNnQjhBY1Ex?=
 =?utf-8?B?Vmozd3N0VkN4cW5FWTZleE1OdWgvS3FEU0RNdm9XTHBVMEI0SmVjUm9Hd3hh?=
 =?utf-8?B?VEVNUCs5K3V2aHB1TkdyTWVNQnA4aDhYSG1WRjFOUUtGSnErSkkxYkZrdHZG?=
 =?utf-8?B?NVVDdFFwcmFPQ1l5bU9JYWIzaXBsK3RoRUtyL2VuczcxRE8rNHRCd3Fva1hh?=
 =?utf-8?B?Mzd6cTVYZGxkcVdJTHdHWUpDeTBwelhhZjJDb3hkNmtMbVAxYVNNQjlFWkhv?=
 =?utf-8?B?TW5ZL253Mm9oKzY5NTNPd29IZHhDMWZJVU1iZHAwNGxEdEZvaWFuejBhTzVq?=
 =?utf-8?B?dVRaaTZyU1VRMjhQOEl4azBXenk0OFpFNGQxU3Qwd1VDQlVWNlBkL1pWMkw1?=
 =?utf-8?B?M0E1K2d1dCtBRVo1SzVzU0hIaWpIblNmTitUOGhDYnZleHZpVExPWEZlMnVl?=
 =?utf-8?B?RmF4REV2TnJPaWsxYXFyS3crU1RuT0FKMW9KTmJsbTUrdlVGdElJSkJJRzds?=
 =?utf-8?B?KzJGdkxDSTRUcFAyRm9MamNENWlHSUFsTldKRUQxMXBRaE5rWVR4bEpYZFhB?=
 =?utf-8?B?V2xVRjMzL3pSTlJnUzRyNkMyN3BCRHNJblZ4ZDRiemZicHZCeTlnVTNDakU3?=
 =?utf-8?B?NzljWWpOVldRbXhtd2VZaHA4aFVFZnQyM0xBZnk4SWI2d25xWDFMc20zeVkz?=
 =?utf-8?B?ekQ1ZHZnWHhmRUhZMEpXaW5ucWRWM2xpK0ttcUZvNXJGeU5lNDVKRUNKTFdY?=
 =?utf-8?B?b2ljSG9iSDBMckdUQjQ3QXo2UGlYQ1ZMUjlqRkhhcW14bHN3cHdwWXFGMk1K?=
 =?utf-8?B?czlmQWNRWUQwV0FYemhRdSt0S0VHeFdMS29wamFPeGlWSXZuWGdYMFNGZG50?=
 =?utf-8?B?MVdlNGlXRUxFeWFQcVhZWThRK3plWEVybDM3dXFkdy9SSVFZcGd3YlRHM1Zn?=
 =?utf-8?Q?+s8MAI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8669442-1318-4437-d5a5-08dbc32fd9a5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 10:10:48.7446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UM0hXoO1fF8Vq4qAvXWEwWPiu5B0Yv0PeObCW4Vl+1L58MflOPcWoLsRgMrpmpUNHVFs26upm9j0pvCv+WOm8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4274
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-02_03,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310020075
X-Proofpoint-GUID: LQRy9tCWwfZkGzUZLwQkYozNQFNb_agF
X-Proofpoint-ORIG-GUID: LQRy9tCWwfZkGzUZLwQkYozNQFNb_agF
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 29/09/2023 18:51, Bart Van Assche wrote:
> On 9/29/23 03:27, John Garry wrote:
>> +    if (pos % atomic_write_unit_min_bytes)
>> +        return false;
>> +    if (iov_iter_count(iter) % atomic_write_unit_min_bytes)
>> +        return false;
>> +    if (!is_power_of_2(iov_iter_count(iter)))
>> +        return false;
> [ ... ]
>> +    if (pos % iov_iter_count(iter))
>> +        return false;
> 
> Where do these rules come from? Is there any standard that requires
> any of the above?

SCSI and NVMe have slightly different atomic writes semantics, and the 
rules are created to work for both.

In addition, the rules are related to FS extent alignment.

Note that for simplicity and consistency we use the same rules for 
regular files as for bdev's.

This is the coding for the rules and where they come from:

 > +	if (!atomic_write_unit_min_bytes)
 > +		return false;

If atomic_write_unit_min_bytes == 0, then we just don't support atomic 
writes.

 > +	if (pos % atomic_write_unit_min_bytes)
 > +		return false;

See later rules.

 > +	if (iov_iter_count(iter) % atomic_write_unit_min_bytes)
 > +		return false;

For SCSI, there is an atomic write granularity, which dictates 
atomic_write_unit_min_bytes. So here we need to ensure that the length 
is a multiple of this value.

 > +	if (!is_power_of_2(iov_iter_count(iter)))
 > +		return false;

This rule comes from FS block alignment and NVMe atomic boundary.

FSes (XFS) have discontiguous extents. We need to ensure that an atomic 
write does not cross discontiguous extents. To do this we ensure extent 
length and alignment and limit atomic_write_unit_max_bytes to that.

For NVMe, an atomic write boundary is a boundary in LBA space which an 
atomic write should not cross. We limit atomic_write_unit_max_bytes such 
that it is evenly divisible into this atomic write boundary.

To ensure that the write does not cross these alignment boundaries we 
say that it must be naturally aligned and a power-of-2 in length.

We may be able to relax this rule but I am not sure it buys us anything 
- typically we want to be writing a 64KB block aligned to 64KB, for example.

 > +	if (iov_iter_count(iter) > atomic_write_unit_max_bytes)
 > +		return false;

We just can't exceed this length.

 > +	if (pos % iov_iter_count(iter))
 > +		return false;

As above, ensure naturally aligned.

Thanks,
John
