Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B6B628287
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Nov 2022 15:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236587AbiKNO3z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 09:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236567AbiKNO3x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:29:53 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27AE1A065;
        Mon, 14 Nov 2022 06:29:52 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AEBixpB009272;
        Mon, 14 Nov 2022 14:29:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=0zcpbriBPpYKBgynpH+AkH5dMoego3+hiw3MuoSIRXs=;
 b=ru+9HALv9G28n1+YyhO5y8/9OxId87FAIvm7mowSaYyAoPq+sjVxrffrkOoyTEePaiYW
 8FFirgH8hSp//9vTO2x2rMVIVMDaFBxJlXsPgIaAF1X01cZg6e8+P+jeIYTsHOVsgwDu
 PlgB4ZV3OCtH0zJ5EYSG3332TmO5zObAdhL2VfUDB9xZKNaoE5XuCyJlUNWcQYw1R7LE
 0PnV0txa7hgBP6TaoDE2homoykZyNaldfj2+TdAZ0mha76aG9wB5RPrT1c/iGZi0D//q
 zCSerg6unc57uDyRy1aG15aGTmMcN3HmlFmdyfcbrwuRDi6B1PQcRvreaL7F4vgOKOM5 IQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ku0x8a6v2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 14:29:14 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AEE7THw020596;
        Mon, 14 Nov 2022 14:29:11 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1xafms0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 14:29:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpD/dggFikTNRF9SsfJrimzQTaVKcg7wPXsq1ejbwDZ5uT4hUPHtiX/M/XnvMfwdJWfJK7EpVApqow9oMd1VRAGokuDISY4GPDpoCkmMeUHFlQRy8INPRyx3i+iDtm9dPrrATp1aOmMGzhYtZESScgHuc8+Xz7T7nl9+L3oHOPQC9ZN1FjlFNq2h6Gq7TI9I153kny1oA40Q9qYOgDI8K30Qp7vxy87LdPJGYwMIOylQ3qmFS1tZFpMtVAQd9KDUXp5HrrfvUWXjWgTsH+R+IBn+YIVf9o7F7nPWoD3IE4RZBRKQ2Lxh56I5c9xq+VBsP6/6+itqyYkKAZK5AaZ6gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zcpbriBPpYKBgynpH+AkH5dMoego3+hiw3MuoSIRXs=;
 b=TMuILALUBlncY2dCkc6FIL0gqTC8E+uC7FVKnKc5ZAUFhR+O6yeaWQCcIwelM5FdCc2i6f1zS5yEEJnpYyY/UEm8H2BaExsrSeVZiSK7Bm6pVnMrBVsyXxXzJxHc9PPUQbtEaUcxBBs+Z5/CR8hak9aMsB/x9EeCxNrsFxJYXMMjp7vh4YErZe+HZCrhudvtpSG3GVu+5SsKw6PSfolD9akGvKuJaL7bR5yig1Wz0sY/sl3WD9FX4znR6eVvgZNDMtGSIDBMm8tnsU2d9pbiMaCz3Hrfxy/OUwo+RMx184OSbm6Cc9J4usWQ9lZ/9XcWlOadjlT1dbGjjaXn2e9zlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zcpbriBPpYKBgynpH+AkH5dMoego3+hiw3MuoSIRXs=;
 b=PYJ53JjeNGMJWR4kkLNqCORO7zs28MLaUNGK9XQfP0OnJ7lrK9Xp9hfVcozCvFhZGjdpIH7vg5PqeBpqFCRVTzaJx5L0gYTMsIN2sMxxX6n+SoKxbOvHv7CWMiGkJFPbDLaAoQknqnVFdRbDfstgrfYy699oYo8w0sSFfrlpEYM=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by CH2PR10MB4247.namprd10.prod.outlook.com (2603:10b6:610:7a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 14:29:09 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::cdac:526e:e65:cfd8]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::cdac:526e:e65:cfd8%4]) with mapi id 15.20.5813.016; Mon, 14 Nov 2022
 14:29:08 +0000
Message-ID: <5be7974a-9b36-75ec-8bd4-e6c74a8f3492@oracle.com>
Date:   Mon, 14 Nov 2022 08:29:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 7/9] jfs: remove ->writepage
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Jan Kara <jack@suse.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Bob Copeland <me@bobcopeland.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net,
        linux-karma-devel@lists.sourceforge.net, linux-mm@kvack.org
References: <20221113162902.883850-1-hch@lst.de>
 <20221113162902.883850-8-hch@lst.de>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20221113162902.883850-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR12CA0002.namprd12.prod.outlook.com
 (2603:10b6:610:57::12) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|CH2PR10MB4247:EE_
X-MS-Office365-Filtering-Correlation-Id: 818575ed-9a66-4b29-be54-08dac64c96f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IUcIpiDWKePwmzhgrJkQhIV2ztz5vThpNwLVzFrJh49KHLp/rUsTSAOh6g2sy2T4fhWq0BFkMIZDOmIXrajbYWxPa/rdvbT/vyeWqVgX+nlxYXlB4GvBhSdca615+dFM8jX/IYWBPB5YWSCqrtGTT6XK3hvc+/lCkgsyJqefqpX1qJvwCJj12m7YUfX7aH0WSS0TCKnzQTp4ncvLNQJ2IB6NfvU7KDsizL9LjTdy4TaTNvbvK4Pl8hLeE56z7PKMGaL6H0+f18xViDwjGxiFgZH/svxA0CyZyERqhwofIzmdOrqxoSooRRlNZHaqovT+hRIf4wabZfTwEoTHA4nEJp+n0IncP4Z8X7s3ds9Xpk8SZwS0JuuMHGlyMsnpJ56xcaAI2e8zqHl9sGC8ZdxYKO8eRD7/+kq3f/Z2ti+Us+Td3lRmS6Ibq6qBIz2hsrHPpIqnBqRrN9Fmt66JvBArcJOLhzkLWraYOLywiptCPqT3OBqeDrIuiwG0fy2a979OEidxhIes3yZGnL98VjnMYdeMakPsWWMQl40jyB9r8dj1KurxtxrD0KAgKLpbop+tMHWmQqUj8CrqXE5wORXw7OK4rPF0Dfa9WN6fZCJMG2kxG28QIK27SleyB0//YHFic4yzk6PxIgW75HYLQRzJrmWSr3gQGdbdJUuc2kjQYTeKWsShRSlLKPbGjuivZoDLvlEcJPSzgzurRmcYmuwSd0l0l4eUTxJGUbecnYUpteL9d0xYZKMt4a9DKRMLsNK528mEQzL/1+xYRmBSw/Zitk+ycClBOd6fZKag+mWIbjA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199015)(36756003)(186003)(6512007)(26005)(2616005)(83380400001)(38100700002)(86362001)(5660300002)(8936002)(7416002)(44832011)(2906002)(31696002)(41300700001)(478600001)(6486002)(31686004)(316002)(66476007)(110136005)(6506007)(6666004)(4326008)(66946007)(8676002)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0V3ZjcxaEdQeUZDdEpReEY1cHN0YjI1SGFiMTY2OXVEcFFtdTFJNlErZVB5?=
 =?utf-8?B?b2x6bXovVy8xRktnb3dDSTAxR3RlcWFMb0V1cTg5UURTeGJzK3FYdlljU2xn?=
 =?utf-8?B?d2V4alNDV1g2OVA2V24rNEViMU5nM2RQdGUvV2VlM2xNODEwSEdYcUlBSUx4?=
 =?utf-8?B?R21POW40Um13eHY3WE5Hc2szQ0VIVGpCb1ZEd2MxcGtLK3YxUUJXQmVma0tp?=
 =?utf-8?B?Tk9aejlTUFNRNGZIeTNHQy8rSUh6eURxb0NzTzAwdTVCbCtNMWdac0oxNEhV?=
 =?utf-8?B?RTNmRFg4Zm5PRWR2Qnh3RlYrL2VqLzEzdFpnQWFSZCtsa1Y5bkFycCt4NWVP?=
 =?utf-8?B?RTFFSnF3RnExU2w3OG5KZzJsL2wyMEQxeGFwVVl4bit4V1F6WUt6bC8vU2p3?=
 =?utf-8?B?ZGp4Ukh1VXh5NVVSTnNGNDhMOVZqSzJFZEZlMGRBejRVS3B1WWhCK0ZVOGVV?=
 =?utf-8?B?emlMaVpPMlFyMzhVZ0RYOXVQRFdkbjVTeEEzUjlsNEpiRzZKUmx5UVp0b1V5?=
 =?utf-8?B?dm9EUFNsNWU1QUd5V3k4ekx6aE1Yb0JZdmdWeU9WWTB0MllHSHVkTGZIOVJv?=
 =?utf-8?B?cTJhbE12MFhNL3NKdDM5N2JkbmRxdk4xbm5pYlBEZWlONnp0bmZ0YTliNFlN?=
 =?utf-8?B?MnRwVXBvRnJkVmFKSC9xUjY2d3lMUG5GL0xoSW05ZEYvczd4ZVVFMkZtWHlZ?=
 =?utf-8?B?NHErRC9remtGMkUvb0p3SDZIVkMwbi82NFoxMkpqUzZETDltT0lIVGpwT0ZC?=
 =?utf-8?B?U0wydEtBZUtUZ2JDbzNWc2Z5TmVJWXV6U2Rqald5NTYxQzFHbTk5RHk2ejFR?=
 =?utf-8?B?TUM2eDVrVXFGSHY3RDg5Tm5SdGlGeU1PcldHbXBqMEV3TGM5SStySk50bHBw?=
 =?utf-8?B?amw1clVDU2FKaHVIdUMrY1Z1TlJLRzI2Zktiay9mWDRjelJiU2tpbmVtZWJk?=
 =?utf-8?B?SWdlNmgvb0RXQkY0WmEzdWVmMlZrNXB0eWc2YmlaY3NQbzR3cGcxVk91M2lH?=
 =?utf-8?B?bFNzaWZjNGxzWHl4bzc5Y0NjaXpBMlR1ZVhZbkhyUG55RXNZRkFGZGd2QUJW?=
 =?utf-8?B?WnEvUk9iS1lGQ0VRVmRkdzlNYklSWmk0N0VLWHFncUNRMHlwbnByNmtjVmE5?=
 =?utf-8?B?MVp0UlZBYVZNdkg5K1I0dzZsMmhZb0Rvb0greDhLSkFpWlhHTUM4OWRXMjJJ?=
 =?utf-8?B?eU9TYXZ4c0lDWGJja2ZQL3ZPSDU0RGJWL2VKeGdZK0FBQjYvTjVscDJDd0pW?=
 =?utf-8?B?TzUwY3JxUHFJVDRoZnhvdFBmUlVVMFdPRUc1UWk5R3k0TERDRDJXSG9kdlFV?=
 =?utf-8?B?cEJ6M3ZRY2laaUR0VG5Db2VwVmY4NGQzNFUwaW00akE4M1o5YXorU2pvVWUx?=
 =?utf-8?B?QUU1ZXljZG5lYitHRW5EelF6a1FXYUF3aElkcVhOTldyYkJoWDNLUmZ5N3FU?=
 =?utf-8?B?bkt0OEo0OHVlaW1MZjZvZm1OUXNXL2x3bjQyaE5pN1BrZ2ZCcy9BdU5qNmVS?=
 =?utf-8?B?Sis5UU9JV2ZtRkdJQTkyV250empsOC9BODJ5NjgyUGV1eFNQMEx0U1dDWDlv?=
 =?utf-8?B?enowTkI5eWpVdCtSd244TkNkNWNMekFTNWkrczF6K2czOFQyQllUYWNmY014?=
 =?utf-8?B?cmFVMnZvbmtvSDZVcURrT3dxMk1GVUIrR3lDNVhZN2RUUmE3c2NZbXdLRnla?=
 =?utf-8?B?RDRxQTIwRXNHNGJpQXdISlI5Q3E4YmRrOUhrWWpxUU12RmNiazA4ZWxCQWxL?=
 =?utf-8?B?VmlMa1dGTlRZZ25Kc1ZxdUlvSEFqMDRmMDFTWW5BWDgwV1JJdW05TEdGTmRw?=
 =?utf-8?B?blhBQjRlSTFVem5kU21mZVlNWHZlOE1obmtJRFpjWjJPSTlVZEFkamtyL3BC?=
 =?utf-8?B?TDJtNjVUeDFlM2NrbWQ3YmF1TnpEdXphV0VwM2g3RFp6cS9SQzdLZnlzMlk1?=
 =?utf-8?B?R3JtSnMyV1VMUzAwNzFaOFgydFQ3TFBHb0VyRm91dEJJZHN3WGZDZVZNcXhh?=
 =?utf-8?B?RlFqRlNJWnoxSm9yUHc5b1ZSeFFHalBVOTh0K1dtQjJXMHJnSmtIbEhuMWFT?=
 =?utf-8?B?d2lzNkZteDhWbHhoa3o1SnZ1dDJtR1ZmbkhldzFSSHBKbXkvR1h2YmlRTFQ3?=
 =?utf-8?B?NEFER3d6aWpaa0Z4cW9vY1AveVBhYW5EWUF0dXN0eE8xUTJGVlVlMGxUaEhC?=
 =?utf-8?B?NVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TjlEcXg5Ny9DQVJud1hVRHJMS2RNd1grR1VFR2FsMi96WGk2Rk04elRzamdW?=
 =?utf-8?B?Q0hPWHcrc2JGSGFRanRYakRwY01NdktyaE8rU2JYaWxwL0xmVXBsZ3ROeVNl?=
 =?utf-8?B?aTNTaGtqbEVUeHJKemtEWWF5OEljZjllRTc5RkQ3a294VFZZTnd2MG1BVTEy?=
 =?utf-8?B?R0NFeXNNLzhUMTdEWjA2bWczNTRCME4rR0dwd1o4M2JtR2dSWnljWjAvV2Nh?=
 =?utf-8?B?RDFjS0RzUkgrZjVHSlk1Si9zNk9VSkpNZDRUZXBTRnBHby9iRnRSc2lnUHRP?=
 =?utf-8?B?T21Rb2VHOHBBQmxEQmN2bGFOMUxFQkxHQTh0M0lOUmxtSmJJYUlQVTZZVktR?=
 =?utf-8?B?aTdhQkMvY3J0dGJMQkdnU3FFSTRnbUpTVGcvYWh6VUs4Y1R4ZDBGRjloQmhM?=
 =?utf-8?B?eW9DRG5YQ0JRZWdXL0NIQVROVUlJM25Cbms1aHJtbWZuRkJXUnJNeFJIRGJw?=
 =?utf-8?B?WEtiQ2F4ZUdUNzZDVmMzc2x3Ti9KK1pVamlaVVA4VDhJL2wxOHNvdjRBTHVN?=
 =?utf-8?B?OGdnbkNLZkVxYS9ZejUwVm85QTV3Y1B1UW12UE9tZEUvYU43OHB2OXFHQTRS?=
 =?utf-8?B?ajhia2pyT1Yxc1hrcUFCdVNCcHN6bHlRY3o4aXdlVXBCUHlyb3RVYVp2aEdl?=
 =?utf-8?B?UTRKaGw0TnVtT2RvWXNMZ0drbHY5d2lleVQvakxmRDVQb2tpVDlBb0FkTkVl?=
 =?utf-8?B?TXFSR1NYVmY4NkhnK2NIb21SblhIeVFiaXVsTEFlSjhFNHU4cWpZT2Z2TUdk?=
 =?utf-8?B?Mlp2QmYydnBqTkZ1TWRWMURpNVNBV2tkdGIrNDBWclMvS2VSMkNkS3g1M1RD?=
 =?utf-8?B?SWtyVDdCTUxvd2lTU3RFdHlWQndVd1doWE8zd0ZpMGtlZGNTbmp3ZUhuNDJQ?=
 =?utf-8?B?OU1Pa09qektmVDc1amhic3JSVE5aWDBoUzYwc2lDY044QWZiWEJ3d3JUYWpU?=
 =?utf-8?B?MTRyNzNVc2hEUlg4aUs1NXBUREhLRXhJbjNLRis0MXFiY0hoUDVUMTlRb3Qw?=
 =?utf-8?B?dktaZHhKamRWblV5RVBkc3N5RExUU015dHl2Vks2WFJxY0pHaDIyaHdMWGlU?=
 =?utf-8?B?M2ZJOEpWRnNpOUl3NHhTRmdCVktHN2xHbWhWMjM1UU02bWNpamhxWTFNK3d0?=
 =?utf-8?B?ZVRJN1RsaUJGUW1Udit4eDBPZENBaVlJRGpyZGRIaW9mVjc4cHVobnJOYWdz?=
 =?utf-8?B?S1hvenRmNWROK1FaQW8rNklmK0l3bHR4VmVGbmJiL0tzNTNZbXl1b1NJb3JO?=
 =?utf-8?B?SFRkbWZNN3F6MmIrWmVrTkJPWGZiSWY5bU9VUXNQWUJST3M3YTB3M1haUTdD?=
 =?utf-8?B?a1doR1hZamoxVmFUUkhSeU1XQXdDdEZaeFBCSkJCVTYyai9BaC9WakthM0hv?=
 =?utf-8?B?NURMTUVVN0dkR29WVzM2Qnc0K2NDdVJvMENLeHQ2d1lsVWtWZEd2U2VmTXZM?=
 =?utf-8?B?WnpvQnJVaXpoVGRoSFU1OWZ5QmNaTWtBMis0U1Q2QnF3dFBQdlhITDJPREh1?=
 =?utf-8?B?U0Uya2VnaTMrMkFLSUl3UmFmUGRNRW80ZUxsY1JYcit5RlZ3NExITUI2WDBt?=
 =?utf-8?B?M1A4U3F6OUwyWitsQjFUSldVeDRvSDR5UkUwZ2t0U3JzME1yZU1Yaml4VExO?=
 =?utf-8?B?dVVnZUxoS01MNElVbFlpbXhYR0pjQnc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 818575ed-9a66-4b29-be54-08dac64c96f0
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 14:29:08.0395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lPUdGd+df6kuFMNQvh8SoudO6rPzQqPPocV+j3kPUrHJY+GmkmWmlIgHOXCz0GPJoHTQSMvyOjCiMtArks4CuLU3/XwPW+S6j/fW9EF5rL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4247
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_12,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211140103
X-Proofpoint-ORIG-GUID: ljDOmqwQcAm5_FIs4ymoblB0W5ARw-W8
X-Proofpoint-GUID: ljDOmqwQcAm5_FIs4ymoblB0W5ARw-W8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/13/22 10:29AM, Christoph Hellwig wrote:
> ->writepage is a very inefficient method to write back data, and only
> used through write_cache_pages or a a fallback when no ->migrate_folio
> method is present.
> 
> Set ->migrate_folio to the generic buffer_head based helper, and remove
> the ->writepage implementation.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Dave Kleikamp <dave.kleikamp@oracle.com>

> ---
>   fs/jfs/inode.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
> index d1ec920aa030a..8ac10e3960508 100644
> --- a/fs/jfs/inode.c
> +++ b/fs/jfs/inode.c
> @@ -264,11 +264,6 @@ int jfs_get_block(struct inode *ip, sector_t lblock,
>   	return rc;
>   }
>   
> -static int jfs_writepage(struct page *page, struct writeback_control *wbc)
> -{
> -	return block_write_full_page(page, jfs_get_block, wbc);
> -}
> -
>   static int jfs_writepages(struct address_space *mapping,
>   			struct writeback_control *wbc)
>   {
> @@ -355,12 +350,12 @@ const struct address_space_operations jfs_aops = {
>   	.invalidate_folio = block_invalidate_folio,
>   	.read_folio	= jfs_read_folio,
>   	.readahead	= jfs_readahead,
> -	.writepage	= jfs_writepage,
>   	.writepages	= jfs_writepages,
>   	.write_begin	= jfs_write_begin,
>   	.write_end	= jfs_write_end,
>   	.bmap		= jfs_bmap,
>   	.direct_IO	= jfs_direct_IO,
> +	.migrate_folio	= buffer_migrate_folio,
>   };
>   
>   /*
