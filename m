Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20BF5F015F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 01:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiI2X0I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 19:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiI2X0G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 19:26:06 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DEF16B245;
        Thu, 29 Sep 2022 16:26:02 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28TNOS2P024770;
        Thu, 29 Sep 2022 23:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=FaD6yuSKBClnHw8RZpnLuXDaLorg73jLGhIeAXDkIZE=;
 b=DqMKk5jGDSewFhYuaxXIfRQjwpwYeGkQXUPuX1ZHIy2KjgOd2Hl73AV/44gH0xkpZoAj
 1hotrODuGZuK/3cNUrV+3Uz8dqBXaBv6+G7ZAU9CmUQKPJj1psbYEitek2DJiQe1aF6I
 3D1huF4YKxxqe1//OtowFpR88nc+5Jj0SPQk8AmMK4JSp3nKtyyZYB1Ga1WCC9oZaISR
 HvP6FiLYgdcke+rg5Hr9FubRAqcqSymGiMwSkVjNNlx51v/XdfX9tpqVWFz4TJLBVRMW
 4JN5Kx7EtZQ1SPox+k5Ztob/tmojoXE5AgF0KwPAk9R6p3bdfjIN7XXvJU0eUVDmU453 9w== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jwn0tg0n9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 23:25:50 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28TNLPBv026510;
        Thu, 29 Sep 2022 23:25:49 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02dal.us.ibm.com with ESMTP id 3jsshaxc67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 23:25:49 +0000
Received: from smtpav01.wdc07v.mail.ibm.com ([9.208.128.113])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28TNPm735309058
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Sep 2022 23:25:49 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C7F158055;
        Thu, 29 Sep 2022 23:25:48 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C5355806A;
        Thu, 29 Sep 2022 23:25:47 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.161.243])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 29 Sep 2022 23:25:47 +0000 (GMT)
Message-ID: <41a0deedf4f035b8470f5fe237d192c9b30b9ba6.camel@linux.ibm.com>
Subject: Re: [PATCH v3 12/29] integrity: implement get and set acl hook
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     Seth Forshee <sforshee@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Thu, 29 Sep 2022 19:25:46 -0400
In-Reply-To: <20220928160843.382601-13-brauner@kernel.org>
References: <20220928160843.382601-1-brauner@kernel.org>
         <20220928160843.382601-13-brauner@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CA9a3H-UeGMrjSJgOU5tTtl3wcVWxrb_
X-Proofpoint-GUID: CA9a3H-UeGMrjSJgOU5tTtl3wcVWxrb_
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-29_13,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 clxscore=1011 impostorscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209290144
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christian,

On Wed, 2022-09-28 at 18:08 +0200, Christian Brauner wrote:
> The current way of setting and getting posix acls through the generic
> xattr interface is error prone and type unsafe. The vfs needs to
> interpret and fixup posix acls before storing or reporting it to
> userspace. Various hacks exist to make this work. The code is hard to
> understand and difficult to maintain in it's current form. Instead of
> making this work by hacking posix acls through xattr handlers we are
> building a dedicated posix acl api around the get and set inode
> operations. This removes a lot of hackiness and makes the codepaths
> easier to maintain. A lot of background can be found in [1].
> 
> So far posix acls were passed as a void blob to the security and
> integrity modules. Some of them like evm then proceed to interpret the
> void pointer and convert it into the kernel internal struct posix acl
> representation to perform their integrity checking magic. This is
> obviously pretty problematic as that requires knowledge that only the
> vfs is guaranteed to have and has lead to various bugs. Add a proper
> security hook for setting posix acls and pass down the posix acls in
> their appropriate vfs format instead of hacking it through a void
> pointer stored in the uapi format.
> 
> I spent considerate time in the security module and integrity
> infrastructure and audited all codepaths. EVM is the only part that
> really has restrictions based on the actual posix acl values passed
> through it

(e.g. i_mode).

> Before this dedicated hook EVM used to translate from the
> uapi posix acl format sent to it in the form of a void pointer into the
> vfs format. This is not a good thing. Instead of hacking around in the
> uapi struct give EVM the posix acls in the appropriate vfs format and
> perform sane permissions checks that mirror what it used to to in the
> generic xattr hook.
> 
> IMA doesn't have any restrictions on posix acls. When posix acls are
> changed it just wants to update its appraisal status.

to trigger an EVM re-validation.

> The removal of posix acls is equivalent to passing NULL to the posix set
> acl hooks. This is the same as before through the generic xattr api.
> 
> Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>


> ---

> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index 23d484e05e6f..7904786b610f 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -8,7 +8,7 @@
>   *
>   * File: evm_main.c
>   *	implements evm_inode_setxattr, evm_inode_post_setxattr,
> - *	evm_inode_removexattr, and evm_verifyxattr
> + *	evm_inode_removexattr, evm_verifyxattr, and evm_inode_set_acl.
>   */
>  
>  #define pr_fmt(fmt) "EVM: "fmt
> @@ -670,6 +670,74 @@ int evm_inode_removexattr(struct user_namespace *mnt_userns,
>  	return evm_protect_xattr(mnt_userns, dentry, xattr_name, NULL, 0);
>  }
>  
> +static int evm_inode_set_acl_change(struct user_namespace *mnt_userns,
> +				    struct dentry *dentry, const char *name,
> +				    struct posix_acl *kacl)
> +{
> +#ifdef CONFIG_FS_POSIX_ACL
> +	int rc;
> +
> +	umode_t mode;
> +	struct inode *inode = d_backing_inode(dentry);
> +
> +	if (!kacl)
> +		return 1;
> +
> +	rc = posix_acl_update_mode(mnt_userns, inode, &mode, &kacl);
> +	if (rc || (inode->i_mode != mode))

acl_res in the existing evm_xattr_acl_change() code is based on the
init_user_ns.  Is that the same here?   Is it guaranteed?

> +		return 1;
> +#endif
> +	return 0;
> +}
> +
> +/**
> + * evm_inode_set_acl - protect the EVM extended attribute for posix acls

^from posix acls


> + * @mnt_userns: user namespace of the idmapped mount
> + * @dentry: pointer to the affected dentry
> + * @acl_name: name of the posix acl
> + * @kacl: pointer to the posix acls

Prevent modifying posix acls causing the EVM HMAC to be re-calculated
and 'security.evm' xattr updated, unless the existing 'security.evm' is
valid.

-- 
thanks,

Mimi

