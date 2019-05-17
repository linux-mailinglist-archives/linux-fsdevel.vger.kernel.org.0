Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 308BB220C7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2019 01:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfEQXrl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 19:47:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58026 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726519AbfEQXrk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 19:47:40 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4HNkroI077594
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2019 19:47:38 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sj5xyhqrb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2019 19:47:38 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sat, 18 May 2019 00:47:36 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 18 May 2019 00:47:33 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4HNlWrX43843664
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 May 2019 23:47:32 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91B0BA405C;
        Fri, 17 May 2019 23:47:32 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1DF4EA4054;
        Fri, 17 May 2019 23:47:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.110.180])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 17 May 2019 23:47:30 +0000 (GMT)
Subject: Re: [PATCH V3 6/6] IMA: Allow profiles to define the desired IMA
 template
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Matthew Garrett <matthewgarrett@google.com>,
        linux-integrity@vger.kernel.org,
        prakhar srivastava <prsriva02@gmail.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.vnet.ibm.com, dmitry.kasatkin@gmail.com,
        miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, Matthew Garrett <mjg59@google.com>
Date:   Fri, 17 May 2019 19:47:20 -0400
In-Reply-To: <20190517212448.14256-7-matthewgarrett@google.com>
References: <20190517212448.14256-1-matthewgarrett@google.com>
         <20190517212448.14256-7-matthewgarrett@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19051723-0016-0000-0000-0000027CE590
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051723-0017-0000-0000-000032D9C42F
Message-Id: <1558136840.4507.91.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-17_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905170143
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[Cc'ing Prakhar, Thiago, Roberto]

Hi Matthew,

On Fri, 2019-05-17 at 14:24 -0700, Matthew Garrett wrote:
> Admins may wish to log different measurements using different IMA
> templates. Add support for overriding the default template on a per-rule
> basis.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>

All of sudden there are three different patch sets needing to include
different types of measurements in the measurement list.  Matthew's
VFS sourced file hashes, Thiago's kexec kernel image appended
signature, and Prakhar's kexec boot command line.  I'd like you to
work together to get this upstreamed.

Matthew, I'm going to ask you to separate out this patch from this
patch set.  Roberto, Thiago, Prakhar, I'm going to ask you to review
Matthew's patch.  I'm expecting all of the patchsets will be re-posted 
based on it.

thanks!

Mimi


> ---
>  Documentation/ABI/testing/ima_policy  |  3 ++-
>  security/integrity/ima/ima.h          |  7 +++++--
>  security/integrity/ima/ima_api.c      |  7 +++++--
>  security/integrity/ima/ima_appraise.c |  2 +-
>  security/integrity/ima/ima_main.c     |  9 ++++++---
>  security/integrity/ima/ima_policy.c   | 24 ++++++++++++++++++++++--
>  security/integrity/ima/ima_template.c | 10 ++++++++--
>  security/integrity/integrity.h        |  1 +
>  8 files changed, 50 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> index 6a517282068d..f707ef7eda88 100644
> --- a/Documentation/ABI/testing/ima_policy
> +++ b/Documentation/ABI/testing/ima_policy
> @@ -24,7 +24,7 @@ Description:
>  				[euid=] [fowner=] [fsname=] [subtype=]]
>  			lsm:	[[subj_user=] [subj_role=] [subj_type=]
>  				 [obj_user=] [obj_role=] [obj_type=]]
> -			option:	[[appraise_type=] [permit_directio]
> +			option:	[[appraise_type=] [template=] [permit_directio]
>  			         [trust_vfs]]
> 
>  		base: 	func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
> @@ -41,6 +41,7 @@ Description:
>  			fowner:= decimal value
>  		lsm:  	are LSM specific
>  		option:	appraise_type:= [imasig]
> +			template:= name of an IMA template type (eg, d-ng)
>  			pcr:= decimal value
>  			permit_directio:= allow directio accesses
>  			trust_vfs:= trust VFS-provided hash values
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index d99b867bdc53..29a71c2e6cfa 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -148,6 +148,7 @@ int ima_init_crypto(void);
>  void ima_putc(struct seq_file *m, void *data, int datalen);
>  void ima_print_digest(struct seq_file *m, u8 *digest, u32 size);
>  struct ima_template_desc *ima_template_desc_current(void);
> +struct ima_template_desc *lookup_template_desc(const char *name);
>  int ima_restore_measurement_entry(struct ima_template_entry *entry);
>  int ima_restore_measurement_list(loff_t bufsize, void *buf);
>  int ima_measurements_show(struct seq_file *m, void *v);
> @@ -194,7 +195,8 @@ enum ima_hooks {
> 
>  /* LIM API function definitions */
>  int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
> -		   int mask, enum ima_hooks func, int *pcr);
> +		   int mask, enum ima_hooks func, int *pcr,
> +		   struct ima_template_desc **template_desc);
>  int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func);
>  int ima_collect_measurement(struct integrity_iint_cache *iint,
>  			    struct file *file, void *buf, loff_t size,
> @@ -215,7 +217,8 @@ const char *ima_d_path(const struct path *path, char **pathbuf, char *filename);
> 
>  /* IMA policy related functions */
>  int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
> -		     enum ima_hooks func, int mask, int flags, int *pcr);
> +		     enum ima_hooks func, int mask, int flags, int *pcr,
> +		     struct ima_template_desc **template_desc);
>  void ima_init_policy(void);
>  void ima_update_policy(void);
>  void ima_update_policy_flag(void);
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> index 55bafce3d9c0..457b071669ff 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -164,6 +164,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
>   *        MAY_APPEND)
>   * @func: caller identifier
>   * @pcr: pointer filled in if matched measure policy sets pcr=
> + * @template_desc: pointer filled in if matched measure policy sets template=
>   *
>   * The policy is defined in terms of keypairs:
>   *		subj=, obj=, type=, func=, mask=, fsmagic=
> @@ -176,13 +177,15 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
>   *
>   */
>  int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
> -		   int mask, enum ima_hooks func, int *pcr)
> +		   int mask, enum ima_hooks func, int *pcr,
> +		   struct ima_template_desc **template_desc)
>  {
>  	int flags = IMA_MEASURE | IMA_AUDIT | IMA_APPRAISE | IMA_HASH;
> 
>  	flags &= ima_policy_flag;
> 
> -	return ima_match_policy(inode, cred, secid, func, mask, flags, pcr);
> +	return ima_match_policy(inode, cred, secid, func, mask, flags, pcr,
> +				template_desc);
>  }
> 
>  /*
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 5fb7127bbe68..2f6536ab69e8 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -57,7 +57,7 @@ int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func)
> 
>  	security_task_getsecid(current, &secid);
>  	return ima_match_policy(inode, current_cred(), secid, func, mask,
> -				IMA_APPRAISE | IMA_HASH, NULL);
> +				IMA_APPRAISE | IMA_HASH, NULL, NULL);
>  }
> 
>  static int ima_fix_xattr(struct dentry *dentry,
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 357edd140c09..f23069d9e43d 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -174,7 +174,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
>  {
>  	struct inode *inode = file_inode(file);
>  	struct integrity_iint_cache *iint = NULL;
> -	struct ima_template_desc *template_desc;
> +	struct ima_template_desc *template_desc = NULL;
>  	char *pathbuf = NULL;
>  	char filename[NAME_MAX];
>  	const char *pathname = NULL;
> @@ -192,7 +192,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
>  	 * bitmask based on the appraise/audit/measurement policy.
>  	 * Included is the appraise submask.
>  	 */
> -	action = ima_get_action(inode, cred, secid, mask, func, &pcr);
> +	action = ima_get_action(inode, cred, secid, mask, func, &pcr,
> +				&template_desc);
>  	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK) &&
>  			   (ima_policy_flag & IMA_MEASURE));
>  	if (!action && !violation_check)
> @@ -275,7 +276,9 @@ static int process_measurement(struct file *file, const struct cred *cred,
>  		goto out_locked;
>  	}
> 
> -	template_desc = ima_template_desc_current();
> +	if (!template_desc)
> +		template_desc = ima_template_desc_current();
> +
>  	if ((action & IMA_APPRAISE_SUBMASK) ||
>  		    strcmp(template_desc->name, IMA_TEMPLATE_IMA_NAME) != 0)
>  		/* read 'security.ima' */
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index c293cbc6c578..33c52466bc8a 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -82,6 +82,7 @@ struct ima_rule_entry {
>  	} lsm[MAX_LSM_RULES];
>  	char *fsname;
>  	char *subtype;
> +	struct ima_template_desc *template;
>  };
> 
>  /*
> @@ -403,6 +404,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
>   * @func: IMA hook identifier
>   * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
>   * @pcr: set the pcr to extend
> + * @template_desc: the template that should be used for this rule
>   *
>   * Measure decision based on func/mask/fsmagic and LSM(subj/obj/type)
>   * conditions.
> @@ -412,7 +414,8 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
>   * than writes so ima_match_policy() is classical RCU candidate.
>   */
>  int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
> -		     enum ima_hooks func, int mask, int flags, int *pcr)
> +		     enum ima_hooks func, int mask, int flags, int *pcr,
> +		     struct ima_template_desc **template_desc)
>  {
>  	struct ima_rule_entry *entry;
>  	int action = 0, actmask = flags | (flags << 1);
> @@ -444,6 +447,9 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
>  		if ((pcr) && (entry->flags & IMA_PCR))
>  			*pcr = entry->pcr;
> 
> +		if (template_desc && entry->flags & IMA_TEMPLATE)
> +			*template_desc = entry->template;
> +
>  		if (!actmask)
>  			break;
>  	}
> @@ -681,7 +687,7 @@ enum {
>  	Opt_uid_gt, Opt_euid_gt, Opt_fowner_gt,
>  	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
>  	Opt_appraise_type, Opt_permit_directio,
> -	Opt_pcr, Opt_trust_vfs, Opt_err
> +	Opt_pcr, Opt_trust_vfs, Opt_template, Opt_err
>  };
> 
>  static const match_table_t policy_tokens = {
> @@ -717,6 +723,7 @@ static const match_table_t policy_tokens = {
>  	{Opt_permit_directio, "permit_directio"},
>  	{Opt_pcr, "pcr=%s"},
>  	{Opt_trust_vfs, "trust_vfs"},
> +	{Opt_template, "template=%s"},
>  	{Opt_err, NULL}
>  };
> 
> @@ -770,6 +777,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  	char *from;
>  	char *p;
>  	bool uid_token;
> +	struct ima_template_desc *template_desc;
>  	int result = 0;
> 
>  	ab = integrity_audit_log_start(audit_context(), GFP_KERNEL,
> @@ -1079,6 +1087,16 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  			else
>  				entry->flags |= IMA_PCR;
> 
> +			break;
> +		case Opt_template:
> +			ima_log_string(ab, "template", args[0].from);
> +			template_desc = lookup_template_desc(args[0].from);
> +			if (!template_desc) {
> +				result = -EINVAL;
> +			} else {
> +				entry->template = template_desc;
> +				entry->flags |= IMA_TEMPLATE;
> +			}
>  			break;
>  		case Opt_err:
>  			ima_log_string(ab, "UNKNOWN", p);
> @@ -1358,6 +1376,8 @@ int ima_policy_show(struct seq_file *m, void *v)
>  			}
>  		}
>  	}
> +	if (entry->flags & IMA_TEMPLATE)
> +		seq_printf(m, "template=%s ", entry->template->name);
>  	if (entry->flags & IMA_DIGSIG_REQUIRED)
>  		seq_puts(m, "appraise_type=imasig ");
>  	if (entry->flags & IMA_PERMIT_DIRECTIO)
> diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
> index 78bd8fea8b35..aea95754d523 100644
> --- a/security/integrity/ima/ima_template.c
> +++ b/security/integrity/ima/ima_template.c
> @@ -50,7 +50,6 @@ static const struct ima_template_field supported_fields[] = {
>  #define MAX_TEMPLATE_NAME_LEN 15
> 
>  static struct ima_template_desc *ima_template;
> -static struct ima_template_desc *lookup_template_desc(const char *name);
>  static int template_desc_init_fields(const char *template_fmt,
>  				     const struct ima_template_field ***fields,
>  				     int *num_fields);
> @@ -111,7 +110,7 @@ static int __init ima_template_fmt_setup(char *str)
>  }
>  __setup("ima_template_fmt=", ima_template_fmt_setup);
> 
> -static struct ima_template_desc *lookup_template_desc(const char *name)
> +struct ima_template_desc *lookup_template_desc(const char *name)
>  {
>  	struct ima_template_desc *template_desc;
>  	int found = 0;
> @@ -120,6 +119,13 @@ static struct ima_template_desc *lookup_template_desc(const char *name)
>  	list_for_each_entry_rcu(template_desc, &defined_templates, list) {
>  		if ((strcmp(template_desc->name, name) == 0) ||
>  		    (strcmp(template_desc->fmt, name) == 0)) {
> +			/*
> +			 * template_desc_init_fields() will return immediately
> +			 * if the template is already initialised
> +			 */
> +			template_desc_init_fields(template_desc->fmt,
> +						  &(template_desc->fields),
> +						  &(template_desc->num_fields));
>  			found = 1;
>  			break;
>  		}
> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index 9d74119bcdfd..9f647b04fc23 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -37,6 +37,7 @@
>  #define EVM_IMMUTABLE_DIGSIG	0x08000000
>  #define IMA_FAIL_UNVERIFIABLE_SIGS	0x10000000
>  #define IMA_TRUST_VFS		0x20000000
> +#define IMA_TEMPLATE		0x40000000
> 
>  #define IMA_DO_MASK		(IMA_MEASURE | IMA_APPRAISE | IMA_AUDIT | \
>  				 IMA_HASH | IMA_APPRAISE_SUBMASK)

