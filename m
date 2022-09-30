Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9DE5F0B0A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 13:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbiI3Lvo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 07:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiI3LvY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:51:24 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C061A3B3;
        Fri, 30 Sep 2022 04:48:41 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28UBdYDV019077;
        Fri, 30 Sep 2022 11:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=0873zP5Ym+NOoGbTgp2b/lpLQtIk2kqoBQisl8b298I=;
 b=ti268sbw8kkegFPmKD+o2R62JYPm85bOMOH35csJnjmnVVDy3/Ym3MD3HWEchrdwoAKp
 HQRfvp1+tsCOqE8MniUKpNup4CP2V3BTXsCaiQfgCdVAT8m5HO7CY5SNSuarXrfNuqAc
 nEnc9EXsergkHq7LdaHhG9Zykwn3bPtupYBObwozecVTrHCsqMtZApDQ1uqOcdOsjzln
 2ZpplS9xvGS/vl+BU5zbVCEEg3KdNf1B/4Xa5TTNe7L4ebgX23CEz/yxkIhUtUEYLPaK
 03OhkZkrIRlCzC1C6sZx+7WOitVrd5IpSLdmp06FQfEi3AKWX90GWokfxxlBmWECuHBE vw== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jwy8js633-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 11:48:35 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28UBZdTL027705;
        Fri, 30 Sep 2022 11:48:34 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03dal.us.ibm.com with ESMTP id 3jsshaj3d1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 11:48:34 +0000
Received: from smtpav04.wdc07v.mail.ibm.com ([9.208.128.116])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28UBmWX154657334
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Sep 2022 11:48:33 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BCB2258061;
        Fri, 30 Sep 2022 11:48:32 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C973458050;
        Fri, 30 Sep 2022 11:48:31 +0000 (GMT)
Received: from sig-9-65-252-31.ibm.com (unknown [9.65.252.31])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 30 Sep 2022 11:48:31 +0000 (GMT)
Message-ID: <e55cf916e5d5a50e293c7dc5b4f00802578eb6d6.camel@linux.ibm.com>
Subject: Re: [PATCH v4 13/30] evm: add post set acl hook
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Date:   Fri, 30 Sep 2022 07:48:31 -0400
In-Reply-To: <20220930084438.4wuyeyogdthiwmmn@wittgenstein>
References: <20220929153041.500115-1-brauner@kernel.org>
         <20220929153041.500115-14-brauner@kernel.org>
         <9b71392a68d9441697fcca12b30e26578ed7423f.camel@linux.ibm.com>
         <20220930084438.4wuyeyogdthiwmmn@wittgenstein>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DmaeM5xkdOJbPTPE18LTj3-t0IYbOto4
X-Proofpoint-GUID: DmaeM5xkdOJbPTPE18LTj3-t0IYbOto4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-30_04,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=982 mlxscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 impostorscore=0 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209300073
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christian,

On Fri, 2022-09-30 at 10:44 +0200, Christian Brauner wrote:
> On Thu, Sep 29, 2022 at 09:44:45PM -0400, Mimi Zohar wrote: 
> > On Thu, 2022-09-29 at 17:30 +0200, Christian Brauner wrote:
> > > The security_inode_post_setxattr() hook is used by security modules to
> > > update their own security.* xattrs. Consequently none of the security
> > > modules operate on posix acls. So we don't need an additional security
> > > hook when post setting posix acls.
> > > 
> > > However, the integrity subsystem wants to be informed about posix acl
> > > changes and specifically evm to update their hashes when the xattrs
> > > change. 
> > 
> > ^... to be informed about posix acl changes in order to reset the EVM
> > status flag.
> 
> Substituted.
>  
> 
> > 
> > > The callchain for evm_inode_post_setxattr() is:
> > > 
> > > -> evm_inode_post_setxattr()
> > 
> > Resets the EVM status flag for both EVM signatures and HMAC.
> > 
> > >    -> evm_update_evmxattr()
> > 
> > evm_update_evmxattr() is only called for "security.evm", not acls.

After re-reading the code with fresh eyes, I made a mistake here. 
Please revert these suggestions.

> 
> I've added both comments but note that I'm explaining this in the
> paragraph below as well.

Agreed.

> 
> > 
> > >       -> evm_calc_hmac()
> > >          -> evm_calc_hmac_or_hash()
> > > 
> > > and evm_cacl_hmac_or_hash() walks the global list of protected xattr
> > > names evm_config_xattrnames. This global list can be modified via
> > > /sys/security/integrity/evm/evm_xattrs. The write to "evm_xattrs" is
> > > restricted to security.* xattrs and the default xattrs in
> > > evm_config_xattrnames only contains security.* xattrs as well.
> > > 
> > > So the actual value for posix acls is currently completely irrelevant
> > > for evm during evm_inode_post_setxattr() and frankly it should stay that
> > > way in the future to not cause the vfs any more headaches. But if the
> > > actual posix acl values matter then evm shouldn't operate on the binary
> > > void blob and try to hack around in the uapi struct anyway. Instead it
> > > should then in the future add a dedicated hook which takes a struct
> > > posix_acl argument passing the posix acls in the proper vfs format.
> > > 
> > > For now it is sufficient to make evm_inode_post_set_acl() a wrapper
> > > around evm_inode_post_setxattr() not passing any actual values down.
> > > This will still cause the hashes to be updated as before.
> > 
> > ^This will cause the EVM status flag to be reset.
> 
> Substituted.

My mistake.  Can you replace it with:

This will still cause the EVM status flag to be reset and EVM HMAC's to
be updated as before.

-- 
thanks,

Mimi

