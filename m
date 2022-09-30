Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270CD5F02FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 04:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiI3Cvs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 22:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiI3Cvr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 22:51:47 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AAA20857B;
        Thu, 29 Sep 2022 19:51:46 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28U2gY5K028294;
        Fri, 30 Sep 2022 02:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=KcsS/B7fDAxgPYaMz1CIBnBVJXdS01Ck9f43sSJsVAA=;
 b=MYme51AEJWpA9BzrwIx6JfquHFQaAPjF3uqgkV603KrSdHUg9wFL6eZzA4jl2IccsDiw
 DvCI0aLtg6+xX/t3M7WlgluIaB7pFoKibgpMel38BzOuGtXfm50O3KP0ugRoNanj+jQ0
 RSVmH3141L4wiUm0NUXCsEECZbQL96J+4R6KV12ChiXiPJEvO9dvzO2cyqr/GUfKAInb
 LDl86bGdwjbuCJTfU07YNd5t/EwamSaT/x8DcVkzF+Nigkh9DRv0U1FYTTdCeDb6t0P0
 tiO+oRV5u3OjoeEUQMANjV5cgtyzgWQfchm8Yq21LMPBfGpEe2col3TYTVm0vXL/utsK qA== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jwqwmg5j1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 02:51:39 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28U2p1QH000806;
        Fri, 30 Sep 2022 02:51:38 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma03wdc.us.ibm.com with ESMTP id 3jssh9wx4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 02:51:38 +0000
Received: from smtpav05.wdc07v.mail.ibm.com ([9.208.128.117])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28U2pbbn1638918
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Sep 2022 02:51:37 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E452058063;
        Fri, 30 Sep 2022 02:51:36 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1BD8B58059;
        Fri, 30 Sep 2022 02:51:36 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.161.243])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 30 Sep 2022 02:51:35 +0000 (GMT)
Message-ID: <f38002ed6d7125dee01cc48f40d161787d6233c8.camel@linux.ibm.com>
Subject: Re: [PATCH v4 13/30] evm: add post set acl hook
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     Seth Forshee <sforshee@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Date:   Thu, 29 Sep 2022 22:51:35 -0400
In-Reply-To: <9b71392a68d9441697fcca12b30e26578ed7423f.camel@linux.ibm.com>
References: <20220929153041.500115-1-brauner@kernel.org>
         <20220929153041.500115-14-brauner@kernel.org>
         <9b71392a68d9441697fcca12b30e26578ed7423f.camel@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TUcDC3TmvStm4hlTbgmuEhrbqzjR9OG_
X-Proofpoint-ORIG-GUID: TUcDC3TmvStm4hlTbgmuEhrbqzjR9OG_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-30_01,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 malwarescore=0 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209300014
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2022-09-29 at 21:44 -0400, Mimi Zohar wrote:
> Hi Christian,
> 
> On Thu, 2022-09-29 at 17:30 +0200, Christian Brauner wrote:
> > The security_inode_post_setxattr() hook is used by security modules to
> > update their own security.* xattrs. Consequently none of the security
> > modules operate on posix acls. So we don't need an additional security
> > hook when post setting posix acls.
> > 
> > However, the integrity subsystem wants to be informed about posix acl
> > changes and specifically evm to update their hashes when the xattrs
> > change. 
> 
> ^... to be informed about posix acl changes in order to reset the EVM
> status flag.
> 
> > The callchain for evm_inode_post_setxattr() is:
> > 
> > -> evm_inode_post_setxattr()
> 
> Resets the EVM status flag for both EVM signatures and HMAC.
> 
> >    -> evm_update_evmxattr()
> 
> evm_update_evmxattr() is only called for "security.evm", not acls.  
> 
> >       -> evm_calc_hmac()
> >          -> evm_calc_hmac_or_hash()
> > 
> > and evm_cacl_hmac_or_hash() walks the global list of protected xattr
> > names evm_config_xattrnames. This global list can be modified via
> > /sys/security/integrity/evm/evm_xattrs. The write to "evm_xattrs" is
> > restricted to security.* xattrs and the default xattrs in
> > evm_config_xattrnames only contains security.* xattrs as well.
> > 
> > So the actual value for posix acls is currently completely irrelevant
> > for evm during evm_inode_post_setxattr() and frankly it should stay that
> > way in the future to not cause the vfs any more headaches. But if the
> > actual posix acl values matter then evm shouldn't operate on the binary
> > void blob and try to hack around in the uapi struct anyway. Instead it
> > should then in the future add a dedicated hook which takes a struct
> > posix_acl argument passing the posix acls in the proper vfs format.
> > 
> > For now it is sufficient to make evm_inode_post_set_acl() a wrapper
> > around evm_inode_post_setxattr() not passing any actual values down.
> > This will still cause the hashes to be updated as before.
> 
> ^This will cause the EVM status flag to be reset.

Sorry, please ignore these comments for the moment.

