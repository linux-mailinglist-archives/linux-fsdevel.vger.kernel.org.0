Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F945570A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jun 2022 03:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbiFWBxw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 21:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377277AbiFWBwW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 21:52:22 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5240443AF0;
        Wed, 22 Jun 2022 18:51:52 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25N1FPnN029418;
        Thu, 23 Jun 2022 01:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=TsI+ILPUKVz3yg7piZ6IP0m7tWX8TJEnXWgNEGMDWNc=;
 b=bY4gNorDsHYNJG2Bf7vLFZ9c7LcQJRlzLlHQz6IP10ZnGAfNcqnbh0O1IuDT8cLTS7Lt
 1nYfP7kdHEM1Lw4ozSdfDo3PWjcfmwa2pobiTI7dFCJciaHxLFjnx6U6CDeCEB1Nu/tk
 VrVoa4J39NN56aQOFrgcjqvsJH45Lhz7wkMMdcK+W6Ya3+SD+xpQvil4WsOCUn8Ac8cP
 gBdgo+Ie6cD9STH9X2471OYHcYpaYBAUsSb5HMaeQa8kYqsrbjmNBeF24EnqX24Uxr08
 PC5z8qPq6ekKDxxDQGQyGsBXEfU3yFv9cPy6N43LUd3l4K2d3SQ4IhVlctaPb5TKZZcW QA== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gvebm0q3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jun 2022 01:50:48 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25N1aPW6003841;
        Thu, 23 Jun 2022 01:50:47 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma01dal.us.ibm.com with ESMTP id 3guk92kbnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jun 2022 01:50:47 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25N1okmM35651890
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jun 2022 01:50:46 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54C0AC605A;
        Thu, 23 Jun 2022 01:50:46 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7AAF7C6057;
        Thu, 23 Jun 2022 01:50:45 +0000 (GMT)
Received: from [9.211.125.38] (unknown [9.211.125.38])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 23 Jun 2022 01:50:45 +0000 (GMT)
Message-ID: <e200854b-116a-cbf3-256d-92a9c490b9bc@linux.vnet.ibm.com>
Date:   Wed, 22 Jun 2022 21:50:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [RFC PATCH v2 2/3] fs: define a firmware security filesystem
 named fwsecurityfs
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Dov Murik <dovmurik@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>, gjoyce@ibm.com,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
References: <20220622215648.96723-1-nayna@linux.ibm.com>
 <20220622215648.96723-3-nayna@linux.ibm.com>
 <e5399b47-5382-99e6-9a79-c0947a696917@schaufler-ca.com>
From:   Nayna <nayna@linux.vnet.ibm.com>
In-Reply-To: <e5399b47-5382-99e6-9a79-c0947a696917@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xCCZ1rp5CwqPjADRXKVg0nEJScoazKR5
X-Proofpoint-GUID: xCCZ1rp5CwqPjADRXKVg0nEJScoazKR5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-22_08,2022-06-22_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=835 priorityscore=1501 spamscore=0 suspectscore=0
 impostorscore=0 clxscore=1011 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2204290000 definitions=main-2206230004
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 6/22/22 18:29, Casey Schaufler wrote:
> On 6/22/2022 2:56 PM, Nayna Jain wrote:
>> securityfs is meant for linux security subsystems to expose 
>> policies/logs
>> or any other information. However, there are various firmware security
>> features which expose their variables for user management via kernel.
>> There is currently no single place to expose these variables. Different
>> platforms use sysfs/platform specific filesystem(efivarfs)/securityfs
>> interface as find appropriate. Thus, there is a gap in kernel interfaces
>> to expose variables for security features.
>
> Why not put the firmware entries under /sys/kernel/security/firmware?

 From man 5 sysfs page:

/sys/firmware: This subdirectory contains interfaces for viewing and 
manipulating firmware-specific objects and attributes.

/sys/kernel: This subdirectory contains various files and subdirectories 
that provide information about the running kernel.

The security variables which are supposed to be exposed via fwsecurityfs 
are managed by firmware, stored in firmware managed space and also often 
consumed by firmware for enabling various security features.

 From git commit b67dbf9d4c1987c370fd18fdc4cf9d8aaea604c2, the purpose 
of securityfs(/sys/kernel/security) is to provide a common place for all 
kernel LSMs to use a common place. The idea of 
fwsecurityfs(/sys/firmware/security) is to similarly provide a common 
place for all firmware security objects.

By having another firmware directory within /sys/kernel/security would 
mean scattering firmware objects at multiple places and confusing the 
purpose of /sys/kernel and /sys/firmware.

Thanks & Regards,

      - Nayna

