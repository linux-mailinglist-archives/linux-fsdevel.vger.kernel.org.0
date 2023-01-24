Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE54679E4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 17:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjAXQLA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 11:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbjAXQKy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:10:54 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936394AA7C;
        Tue, 24 Jan 2023 08:10:44 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30OEmq3B021416;
        Tue, 24 Jan 2023 16:09:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=U2b+Ik0VEKqD/SVi3y2s9u8whZa8HLwGu/ogM56tOns=;
 b=ei8w3usRX+kA6R1IUaM6uXGfheUwD413Nqjye0tvYI896OOMw3/lkZPUOOY6/o/ifMje
 SQ+6prDcupns9RQrIJRIP/Yvn1RlQGwDKoStGhidi+r4SU2gvaAhYmCTM8LSSBAMwFJi
 6qACE6ns+o9Xbgv/EjvSU0BdSGhAN9oPhp++rJhBFWVDOQH3eQ8BFmyGRXGLOSTcqhjS
 p29XCS0/5/Fe3UQXgRHa7APtjdZfNAee1ByrdyyrinaWuO5mShgLAjOzT5vS+Eh0GBwM
 D+zT9uAcfsVV1OT7PAtpz/cCMOoqvVlRtlPO6jdOFp5t7wQnI2T6IptyPWpX+EczjcEu 3A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n87xa5p74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 16:09:02 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30OFe6tE005863;
        Tue, 24 Jan 2023 16:09:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g5400x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 16:09:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqvcrzndxEZZ2H6gCkkwhyydT7AupvU2Okq8b00A+ps3NEq2yGHBOYFjRpr6kn7szV86GVTXXuHW8PkS9Yr2LRdaST+8EHXHofqtfadBovzi4l7xHGX46neDMbE5/nxJlYX+SJpjaurJ8BwpJUm3kZk3IA6NlTf1l6aSyUaXHUQDsoDHLxAscuTPC8wgJRWNCZ06yDcJw7ymy6sQuP4CXdSl59J+n4UUslpHH+Qq3eYVgvDM6hJtzZ3pulI/Kdh3h79SiXT9/GNr+Q4LVMVaqnROmoQSDRmjSPlq1bMYJ3mjUET/kLQegAFhhzZz1vKJVGAhIOOr46FQ811VsjEVJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2b+Ik0VEKqD/SVi3y2s9u8whZa8HLwGu/ogM56tOns=;
 b=naK6ewaJvLwzQbnH7lccS2QvoPFUxbwoMCE0MvQtl7xk1WrCArOwHafDw5kFh8m+2+QqQPKaG/T7rAPCKf4taXP0PNtSsqbh3bvO6ma35XWIDMM1HJlHNzxDKm66iX4BOod0wBnt6jDCKGFXg53T6mkgikbNiby4t6cTJVuDEVDTF64sbXk1d/UgdQAxc6AqCGpf6Zt7nRtIl8HDVEYhLltblO+AOSJdIWq8/iB4pZCM0cuxU+YQWUTuImljPCq242QIPom4osQSX6KWbKbV3wbYnIq+AtF7w8UmDMnwOkXDv6jHc6hLijrEmfelfEyiCwC+XdUthuH1/ScafRtelA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2b+Ik0VEKqD/SVi3y2s9u8whZa8HLwGu/ogM56tOns=;
 b=ZO7dyAuSrT8yYnmDxPox30L59OnEA8T4scsVaMHNXy2E0CRSb48B7jTm8dkOBQhUu3PrHLJ0ud7AbZlphmEgMDrHHuelVstNt1VFRYwPp4+h/yApjeGxKYDA3c0eFnDXQfcwxovBYUaivZ+fPNdqgRPdYcBRQ+vMR0N3CxjLKtk=
Received: from BN0PR10MB5030.namprd10.prod.outlook.com (2603:10b6:408:12a::18)
 by SJ2PR10MB7060.namprd10.prod.outlook.com (2603:10b6:a03:4d3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.12; Tue, 24 Jan
 2023 16:08:58 +0000
Received: from BN0PR10MB5030.namprd10.prod.outlook.com
 ([fe80::1316:4a15:2f17:cadf]) by BN0PR10MB5030.namprd10.prod.outlook.com
 ([fe80::1316:4a15:2f17:cadf%9]) with mapi id 15.20.6043.017; Tue, 24 Jan 2023
 16:08:58 +0000
Message-ID: <48953bf2-cee9-f818-dc50-5fb5b9b410bf@oracle.com>
Date:   Tue, 24 Jan 2023 16:08:46 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v10 0/9] KVM: mm: fd-based approach for supporting KVM
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        wei.w.wang@intel.com, Liam Merwick <liam.merwick@oracle.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <Y8H5Z3e4hZkFxAVS@google.com>
From:   Liam Merwick <liam.merwick@oracle.com>
In-Reply-To: <Y8H5Z3e4hZkFxAVS@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0114.eurprd04.prod.outlook.com
 (2603:10a6:208:55::19) To BN0PR10MB5030.namprd10.prod.outlook.com
 (2603:10b6:408:12a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5030:EE_|SJ2PR10MB7060:EE_
X-MS-Office365-Filtering-Correlation-Id: dce20b87-ff35-47f5-104f-08dafe254cc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /GET9ICsEcC3To0bmci5+A8IZB0N9mXQT9L6gxJo1rKpVBatkVOfZKRrIFNmw4hiArfj33Rx9oQCtipw3bHEJgDrdUECkrpXr/SdwCtg8dK3XM0wrTH+QR7F82Komo5p6lEuScEXDIpaLp496wN/RPHSdjVsN7PNL+Rxg+prkjhwWjl90aa3uZCXMvaxHDoCgn2SL8WyA2E6gTYNgA51fdT4rkcYn+oonLwYFrjfHoHM5/tHYoKehemQ64DHiCnb1AJ/eIHkRBm3wmHl3DyiOo35g/XaUW5oZM8livfIAGcIibNpdXnqJQhTiOgwwb124tIJ/XDrH6O0Aa9K4m3hEVulhjBzrnEEBG4xPQ8Nz4EXn0+9+ekVZb1LfaSMD016uCb0HAM0Cn28VLgE2oSX3kuTnpiupxxpcGVrkS6S9in/7VNw0aVLOISnskPsCo0VS3Elb3i9QBJ7NY2hBZkCUCwuXuh3Dv7oQxcdRBhaymhWoNsnMv2sxa4m8sMgNu5k3ftM876buR3Pj9e7RaMbuu5FxSH0nlnRIKVtE2ehaNVxYU6I2wNTqGBETPYbyuXmPNqI294/3u7iPNqRwb8lpX9SCQ8lJthi5R4GOscv3j2lEYqr3MQeDEXGzVUNCrOVAErbJqtSUAeP8V6d91SfPbqfgjznBEuBiMJ0yCQ4tU63SNKFpuBHX1dJMNQsowBl3j9SNvkjeqgCpOEXuH+Gac+0AVpGoPCUMh3ZDdupYwfBnx3jNYqu6Z0IBLFPEBKe6OfDrcWzvFOLJj0BQERJZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5030.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(136003)(39860400002)(346002)(396003)(451199015)(316002)(7406005)(110136005)(54906003)(7416002)(5660300002)(36756003)(6506007)(186003)(6512007)(26005)(53546011)(8936002)(6666004)(2616005)(6486002)(83380400001)(478600001)(31696002)(86362001)(44832011)(2906002)(107886003)(38100700002)(66476007)(66899015)(41300700001)(31686004)(4326008)(66556008)(8676002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjFwOHMzNjFyS1hWVjQ2NENkSGFpUGZwUzVmaGJmaTV6Q2tHUVorM0RXK1gy?=
 =?utf-8?B?TkR1WjVEdEgyVFNJcW1XRlJKVXRldXJGdmc5K1hnQmxLWVZrUmRGMUhwREVu?=
 =?utf-8?B?RFMyNmR2Nkd3S3V3NmRRMUNtcFZoOCt4OVJtYzcrRk1oWjB3NnI0TkM1R1Zt?=
 =?utf-8?B?THJsK0xqRkVoWGpnSUlKSGQ0L2ZpY2x2eHlqbXZEbXUrcGhTcENjSWNrUDlU?=
 =?utf-8?B?aWtlNUt3cmlOWjVUSWFiMmhIU0pvMkVzNFBCRWhMdFJybGozZU1sY25mYnZQ?=
 =?utf-8?B?enFoRU1iR0s5MlFwYnh1Vk1pU2hwak5oSzlNRjhJdXg3ekpzbCtVOUM2UTlW?=
 =?utf-8?B?dmE1UmZlTHB0K3loc25NU2ZqS1FyOGoyUTAyUXhMbkdoWFRPejllWk03eDRn?=
 =?utf-8?B?SHljY3VJdG56bkJ2WVhldGpQUnJreFJ3VE9jTkw5L3RSejdndmk4cENKRlQz?=
 =?utf-8?B?Uk9odVpqaWp4NGhTdlV2QzhCVmdwWEtxS0JBcVIrSmt0RWdXYmRlYVpNUmZi?=
 =?utf-8?B?VDZjMUNsazNSdms3TE5zaWtDNlRSbGRFTmZWanNrdC93UTd5Q0plYlJYZUo1?=
 =?utf-8?B?RjVFb1RId0YxaHZFcExXM1lTMUt4WWg1TFJLQVNYQkpGaCsxYWUwWER0alZS?=
 =?utf-8?B?K0I4ODdmMTU4c3g3VDdYTWt5UGg5TU9JckVnUDBmd0ZQK0ZkZXFDbDVLTlpI?=
 =?utf-8?B?clBFQlIxcjFFR2ZkOVVDUTJlcjhhUEFSTXE4T3NmRElkc0NVcng5US9zVGd0?=
 =?utf-8?B?b2o2TEZTYmZtbSttVExOSkpvaHhNVzlHNmhldXBkazdEb3FUWHlBekRPUlkz?=
 =?utf-8?B?czc4b2RDQkhBSUpxNkJKVmZaNXJFaEw0cjdwdDYrSkhRUy95YnUwdWIzN1R6?=
 =?utf-8?B?SzBMK0tQSUxUQXp4SzZmMkRqZk0yd0tQTnlxVHQ2QXFSa2lrTkZFM2tQOU5U?=
 =?utf-8?B?VkJBd00yRldwT2ZVRFVjSFhPV1VJZXd3aE9adHF1L0FLdlQ2V1p1aDFqR1dr?=
 =?utf-8?B?ZHhocit1UWkxUW5RMmt4MU5SejRBRHVnVjR0bGhtWGdROExYa3BYZEdpaUhY?=
 =?utf-8?B?Q0JXdXFud0hpelVlSHpjdmU1SE43YmhGQVJFMU16ZDJndXpna2tqbHpIai9k?=
 =?utf-8?B?K3ZRYUM2dzgyK1pTeGMza2twV2VLbmhkS1FjT1BGYzZ3S0pIV2lDdEc3QUJH?=
 =?utf-8?B?N0VJNFoxM3p4eDlxckt0cFlIZWk1aXBvd1lucmJCV2htVzY5ZXB6YlJYSXI4?=
 =?utf-8?B?ckdGRTY1MCtuZmRGcGdnYUYwUFR2Zk43UG1LN3VDM1RWaTQzSStjQXhUbW16?=
 =?utf-8?B?S1I3bEpIR3VEcWo3VmJ0NGUzYzlqT2xTTk1MYVJXOXEvUk1NejRNNzdNdm1D?=
 =?utf-8?B?MVQzaWVjWXNjZzNTaFlKUjZ2SWlYVkYwbUtLRytGTlh5UklVRTRzMzBKaVlB?=
 =?utf-8?B?c3BpdmFLU0ZEYzRiVDVlMVpNeVJvMnM1cmpCR2lTdFIwWERLeEQwdklLN1Fx?=
 =?utf-8?B?UXFEYWtMT25pWmdJTWRCMnpHelRWWHVidTBkWjR6ZDBtQTlETVIzOHd3N0Jn?=
 =?utf-8?B?eWx4VGhwQzlOUTdRcDdObW91dTBBSDlVUG9ST3FpV0xMRkpXMjE3b1RHN1Bl?=
 =?utf-8?B?WmVoZlByRnM0QkZNZWhHSEh6QkRjZU9rRitvc1k5Q0VuM2szeTUzMGJmZDFz?=
 =?utf-8?B?bUd6NFFtTHZlKzM4S0x1ZU1TcHlhUUphQ0RZcE5zQ3pLUGJMM0crRXVEdXMr?=
 =?utf-8?B?MUNVU2QzR09iZHlqcXA2TFZMcnZRa0JGUzNaY2V0OVBvUVY4OTFrdHhDdlMx?=
 =?utf-8?B?c2N6TlMrNVJWMkVNWmpvbVdSS0I0QlZhcFZLMVlOVFZwYnk1YnQ3NkNjR1k2?=
 =?utf-8?B?cWRHVjRGYmREVmdhcHNoa05JYVZqWnI1Njc3end2MmNVUE9TYUpGeXIrdE9N?=
 =?utf-8?B?S0hIYWY5MERwM0k2K3JsR1JKRmZFL1dJUktXcVVlNFB4elFBUVBQc2JZeC96?=
 =?utf-8?B?VDJESnAwOU5PU24rL2xpaW92WFdRamh3UkUwQ25veUhUNEJXMVpaemZLYUQ4?=
 =?utf-8?B?NnJHcS96dmpjNS9MUUVRSHBSNjFENlg3MTVlci9vaUljN3NTdExOaGYwdmZ5?=
 =?utf-8?B?MjIvSDZrU3JGTDgyWEFpdWdmclU1ZVB0cFZuZWtiNHRDcXROSzlCQUdrN09k?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?b3dLRFViREw1NFhTMVp4eFBaNlZVa0VrLzhlOFc1SXQ3Mkl0czRPcVFzUVEy?=
 =?utf-8?B?SWh4VE9VRnVOL21zekFVclE3RDNCSXdyczhUTVg1TEUwOHAyTTZHcWpFSVRX?=
 =?utf-8?B?RFliYnZCUGZzZG1XM0ZFZ0Z1NkhURFBFVXFuNlZKN083UWh1c3FJZS9NbDV0?=
 =?utf-8?B?cW01bWEyYjVOTXgzN0k5anlVUFpDb2ljdjZYYWxLZzRSQkovZHNxOTFRY0N2?=
 =?utf-8?B?VG9RUzArdzlhcGVVUjJaYlFKSzJpNEV0UEdIekhTLzl0TVUyZVBxTnBFKytn?=
 =?utf-8?B?R0dVZEZna0FHQi9wK1VWV1ZrMnBNb2NWOUI0ZnhqWXBDLzNIVW1IaTRqakZC?=
 =?utf-8?B?NjdDMXJMSnl2U21wa0RvRk15NUxJN3VOVnVWckJFamJHSldudFpMYU9EYmI1?=
 =?utf-8?B?VmZvcEE2eGY0ZkZCcXJxeWhHQlE5MmFYdkJyeXA1YmdNMVRHTU1veW8yY2lN?=
 =?utf-8?B?d3R0UUZHTVk4M0JURy95S01nZTRRNHM1d2dGVzNLYk1XMnhJK0pnWXNzYnJT?=
 =?utf-8?B?UDVuN053S3Bqek1RaEVkajVjT2tzR2ZzT2tRNnl1cW03K2JFcjVLWkwyWUI4?=
 =?utf-8?B?a3k2U2x5OWNiMUpsOG1oQWNUODRyQ2U3ZTdUNzJOYVNsMFR1dmZlSms0YWx4?=
 =?utf-8?B?My9TcXAxY0hqYU4vVE5zSmJiLzNhRklLK0tMeTJvZldFbnZkRnE3Rmd6d1Ur?=
 =?utf-8?B?d0dUVjIzRVZISm5EbXZham9EYzBwR29YOWxHd1crZnFyTS9vbXJrRW9LdEsz?=
 =?utf-8?B?OHA4OS9kaGZ3blFvQUJUUEFmSloyeCs1bVJJSWFCYmcveHBDd0daQUpTVWJD?=
 =?utf-8?B?V0IzNjZFN2M3b043K3pCQjdiRTlaTFlBcXJYTDMrUWpLbWtndG1IdmZHb2hV?=
 =?utf-8?B?L2dWMjh1bEVnQ0tzVEtKTURKYktqMmtYWUZzOXRVWXFoUE5yczVOQy9QOEZE?=
 =?utf-8?B?enJWdHI1Y09peFdodnYwTExmWGJlaXlIb2l5NFdNMitOS3dCMXVkVGZIUUlj?=
 =?utf-8?B?NUpsWDBBT01QKzJXSmFEdWNvUjJmcXNsZzF2emxjSHl3KzFSbmVsWDhLVnNL?=
 =?utf-8?B?NGZYYThyR2NockVhSTk2ZWFWc08rSnBYUVAzWlpjNmhWSEFaNUJmS2hXYjE5?=
 =?utf-8?B?UThhN0ZTTjVXUFFuTmFxQXAwc2krTmlPYUd0dzBsblBySm1XbjVob3RWQmlx?=
 =?utf-8?B?Qk5qWk1TNC94Y0J4Z05uOVI5L0NuZ0VmNTdrRGw2ZnVrZy9ocTN0T1k5TGg3?=
 =?utf-8?B?WXh6ODVUa3c3by9PbHM4dkp6cWFxak5wTlZ0bnVyMk9lS3FoZXN5TW03YmE5?=
 =?utf-8?B?RFVzREh5N1Z6aWZLTU9vUFpUYU9SMlgwNUlraUxhdENFVTZBL1BwYTlueEJO?=
 =?utf-8?B?em56OE5OSjNrc0tYaitTdFVSbWc2Rm1QVExTOEcyQk5leEhmN1lQQ2wrRHpx?=
 =?utf-8?B?cHh3VTFnNVc4ODNuSDFKRlM4SWRtTnVYVSs0SlpOR1I0alMySGZIMCtVK0Ri?=
 =?utf-8?B?dmZyT3k4UWZJQm44ZUgrNEgvMDdDUy81VGVVVDR3TE1kN0YxZHNXdCtRRzVT?=
 =?utf-8?B?eDE4cExWMURxdmtvby9XUGNhZTBZWFRsTHdyYVlsVC82VDFhT2ZtUFRjTnZi?=
 =?utf-8?B?NWhuNGpPMmFIZktKdFUrV2xEZmNlQk1lNTVPVFBmYlpFOUNCN01lVWdDRmhU?=
 =?utf-8?B?KytDUnc4ZGpIVkhLWDlLU1RDcTNPa2orc1JNMGRFcFFSOHhrWEF6bms5ZFZQ?=
 =?utf-8?B?cVZSV3hUUzZqM3d4S3FnNWp1M1Z3dDRTeW9JeE1uaUlBMlRDU3JLQWdFeGFx?=
 =?utf-8?B?eU5hNmU4VUxabnROTnlmWDJNdnAzd0RIRlNqdlRqM3Q3WEV1VXhXdGYraXph?=
 =?utf-8?B?b0prK2VaSUFRRFFBTWhacnpJY2NwMmZWd0xZKzVoK2d6TmdFR2ZhNFFsV3V1?=
 =?utf-8?Q?FQ8bVPgS2LfOIh9GW761zZuasqxvioKa?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dce20b87-ff35-47f5-104f-08dafe254cc3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5030.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 16:08:58.7672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4HNMcaWdysk6alWcELM1QJVCDy3FuLeD6L5UO3V3fp/9HUXhsjrOQxmOOMCKGNmN0Yre2k/Uw2uHE1G8rZt7nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7060
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-24_13,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301240147
X-Proofpoint-GUID: KOu-tinTBr2sknMIpclsYSY4heeekY0c
X-Proofpoint-ORIG-GUID: KOu-tinTBr2sknMIpclsYSY4heeekY0c
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 14/01/2023 00:37, Sean Christopherson wrote:
> On Fri, Dec 02, 2022, Chao Peng wrote:
>> This patch series implements KVM guest private memory for confidential
>> computing scenarios like Intel TDX[1]. If a TDX host accesses
>> TDX-protected guest memory, machine check can happen which can further
>> crash the running host system, this is terrible for multi-tenant
>> configurations. The host accesses include those from KVM userspace like
>> QEMU. This series addresses KVM userspace induced crash by introducing
>> new mm and KVM interfaces so KVM userspace can still manage guest memory
>> via a fd-based approach, but it can never access the guest memory
>> content.
>>
>> The patch series touches both core mm and KVM code. I appreciate
>> Andrew/Hugh and Paolo/Sean can review and pick these patches. Any other
>> reviews are always welcome.
>>    - 01: mm change, target for mm tree
>>    - 02-09: KVM change, target for KVM tree
> 
> A version with all of my feedback, plus reworked versions of Vishal's selftest,
> is available here:
> 
>    git@github.com:sean-jc/linux.git x86/upm_base_support
> 
> It compiles and passes the selftest, but it's otherwise barely tested.  There are
> a few todos (2 I think?) and many of the commits need changelogs, i.e. it's still
> a WIP.
> 

When running LTP (https://github.com/linux-test-project/ltp) on the v10
bits (and also with Sean's branch above) I encounter the following NULL
pointer dereference with testcases/kernel/syscalls/madvise/madvise01
(100% reproducible).

It appears that in restrictedmem_error_page() 
inode->i_mapping->private_data is NULL
in the list_for_each_entry_safe(inode, next, &sb->s_inodes, i_sb_list)
but I don't know why.


[ 5365.177168] BUG: kernel NULL pointer dereference, address: 
0000000000000028
[ 5365.178881] #PF: supervisor read access in kernel mode
[ 5365.180006] #PF: error_code(0x0000) - not-present page
[ 5365.181322] PGD 8000000109dad067 P4D 8000000109dad067 PUD 107707067 PMD 0
[ 5365.183474] Oops: 0000 [#1] PREEMPT SMP PTI
[ 5365.184792] CPU: 0 PID: 22086 Comm: madvise01 Not tainted 
6.1.0-1.el8.seanjcupm.x86_64 #1
[ 5365.186572] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 1.5.1 06/16/2021
[ 5365.188816] RIP: 0010:restrictedmem_error_page+0xc7/0x1b0
[ 5365.190081] Code: 99 00 48 8b 55 00 48 8b 02 48 8d 8a e8 fe ff ff 48 
2d 18 01 00 00 48 39 d5 0f 84 8a 00 00 00 48 8b 51 30 48 8b 92 b8 00 00 
00 <48> 8b 4a 28 4c 39 b1 d8 00 00 00 74 22 48 8b 88 18 01 00 00 48 8d
[ 5365.193984] RSP: 0018:ffff9b7343c07d80 EFLAGS: 00010206
[ 5365.195142] RAX: ffff8e5b410cfc70 RBX: 0000000000000001 RCX: 
ffff8e5b4048e580
[ 5365.196888] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000000
[ 5365.198399] RBP: ffff8e5b410cfd88 R08: 0000000000000000 R09: 
0000000000000000
[ 5365.200200] R10: 0000000000000000 R11: 0000000000000000 R12: 
0000000000000000
[ 5365.201843] R13: ffff8e5b410cfd80 R14: ffff8e5b47cc7618 R15: 
ffffd49d44c05080
[ 5365.203472] FS:  00007fc96de9b5c0(0000) GS:ffff8e5deda00000(0000) 
knlGS:0000000000000000
[ 5365.205485] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5365.206791] CR2: 0000000000000028 CR3: 000000012047e002 CR4: 
0000000000170ef0
[ 5365.208131] Call Trace:
[ 5365.208752]  <TASK>
[ 5365.209229]  me_pagecache_clean+0x58/0x100
[ 5365.210196]  identify_page_state+0x84/0xd0
[ 5365.211180]  memory_failure+0x231/0x8b0
[ 5365.212148]  madvise_inject_error.cold+0x8d/0xa4
[ 5365.213317]  do_madvise+0x363/0x3a0
[ 5365.214177]  __x64_sys_madvise+0x2c/0x40
[ 5365.215159]  do_syscall_64+0x3f/0xa0
[ 5365.216016]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[ 5365.217130] RIP: 0033:0x7fc96d8399ab
[ 5365.217953] Code: 73 01 c3 48 8b 0d dd 54 38 00 f7 d8 64 89 01 48 83 
c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 1c 00 00 00 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ad 54 38 00 f7 d8 64 89 01 48
[ 5365.222323] RSP: 002b:00007fff62a99b18 EFLAGS: 00000206 ORIG_RAX: 
000000000000001c
[ 5365.224026] RAX: ffffffffffffffda RBX: 000000000041ce00 RCX: 
00007fc96d8399ab
[ 5365.225375] RDX: 0000000000000064 RSI: 000000000000a000 RDI: 
00007fc96de8e000
[ 5365.226999] RBP: 00007fc96de9b540 R08: 0000000000000001 R09: 
0000000000415c80
[ 5365.228641] R10: 0000000000000001 R11: 0000000000000206 R12: 
0000000000000008
[ 5365.230074] R13: 0000000000000000 R14: 0000000000000000 R15: 
0000000000000000

Regards,
Liam

> As for next steps, can you (handwaving all of the TDX folks) take a look at what
> I pushed and see if there's anything horrifically broken, and that it still works
> for TDX?
> 
> Fuad (and pKVM folks) same ask for you with respect to pKVM.  Absolutely no rush
> (and I mean that).
> 
> On my side, the two things on my mind are (a) tests and (b) downstream dependencies
> (SEV and TDX).  For tests, I want to build a lists of tests that are required for
> merging so that the criteria for merging are clear, and so that if the list is large
> (haven't thought much yet), the work of writing and running tests can be distributed.
> 
> Regarding downstream dependencies, before this lands, I want to pull in all the
> TDX and SNP series and see how everything fits together.  Specifically, I want to
> make sure that we don't end up with a uAPI that necessitates ugly code, and that we
> don't miss an opportunity to make things simpler.  The patches in the SNP series to
> add "legacy" SEV support for UPM in particular made me slightly rethink some minor
> details.  Nothing remotely major, but something that needs attention since it'll
> be uAPI.
> 
> I'm off Monday, so it'll be at least Tuesday before I make any more progress on
> my side.
> 
> Thanks!
> 

