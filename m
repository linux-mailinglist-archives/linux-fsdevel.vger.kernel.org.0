Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB37C6A9FF7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 20:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjCCTT2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 14:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjCCTT1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 14:19:27 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9077AD51B;
        Fri,  3 Mar 2023 11:19:26 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 4FF0F32007F0;
        Fri,  3 Mar 2023 14:19:25 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 03 Mar 2023 14:19:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1677871164; x=1677957564; bh=kuuJpFZokkDlh5b4z6JvJ1JyByWlwqXcZja
        +DHm8hpw=; b=fpvukAdplsmW6tJuXyM+pJou2LfqV6qn97jo4szAzlfiRiedFHs
        iqHmpEbltr4t6YJ3zXoQtH382LQnmggJfW6Env+5jWapfvzZesTrQYjuuDY3/TD3
        Vgo9d5ty8t08HYh+3SOshwBrqujdgAbr7ziPmAvA/NeG/w7ITT0SXJuoH+6zTtiy
        GnZN1ozlw+HDUcExLHXG77GffJj6/CYu5EwDCzz31Tr6Vir52wACh7/67tvnI1hC
        IKbip/kCV5L6DL+ze6D7NsyEAiaA9jFZDJ26IrDcEb8VXJ6ASCbFBinqoWIdr5UH
        qAUr/Zf/QfZcfjdhUKSyeCy6HT9ge5Xe6Fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1677871164; x=1677957564; bh=kuuJpFZokkDlh5b4z6JvJ1JyByWlwqXcZja
        +DHm8hpw=; b=byKh/D2nacvYUMcRoCvOlPjBPoXNKGiNa9YSqqb/toZYz40zBke
        qScPGdT8IAJ7ZCzpqY50LFS9QO0pNaVX03tAHmwWX4tNIIX16nbdzuqcRFksWNzH
        NamRzjMkyvRjx+2kJ58JywqYBP++rfzEhbbhPwVxVauuP9CieM/Dm2Tm6wHPcOSh
        rcoPS3xxpmdsfXnHMtVNfdFfuWoCo3CdCT+Kkiu+zv5aYo/TMg9e3h5TPqMLktcA
        M2Kg4zOwg2dAGz5c39LowE6oEuh/oU2U6uzCuqrY7Y4ZPPlP0FMkGRKvGcGY+wif
        shib6UyGLgblcVueI+lV/gaDJtvF4o6XYAw==
X-ME-Sender: <xms:PEgCZIdw80iTA432wsx4cbt3oa9adUYbZQe53C3Pvq-mkmqp0uL0_Q>
    <xme:PEgCZKNPKt17AbdqMTPn0qVCiUHXWtTvnkBmQBJugXtW4QOZrCXg-9ekIu_QqybPa
    ywhRUQjB6pDhS_s>
X-ME-Received: <xmr:PEgCZJiyNOpwENRnW1gLSjHsnWI9bt0aJ679RBc1_uObz6LjYxvzgZBPRdBRRxGztg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudelledguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttdefjeenucfhrhhomhepuegv
    rhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrg
    hilhdrfhhmqeenucggtffrrghtthgvrhhnpeffhfdtvdeviedvudeuudejteffkeeklefg
    vdefgfeuffeifeejgfejffehtddtfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhl
    rdhfmh
X-ME-Proxy: <xmx:PEgCZN8G6MlEjegenNjhD6rwiXjkfrqX0jioj6nLPCb1aLn6PC5iDA>
    <xmx:PEgCZEsLz2HY92dgkRLS0yNbJKLILpu3pJDFXpaycuGMAmWxroZZBw>
    <xmx:PEgCZEHNV51TE8L997iTgIpFFHHQZbrIUl0F2wn2b40oG2tkwhgm5g>
    <xmx:PEgCZFkGC0Ka_RZNviuOaNRnSsbWSxoxDOZsVH6XVpSPF45Tu-whOQ>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Mar 2023 14:19:23 -0500 (EST)
Message-ID: <e49787bc-fd4f-1fdc-e66b-270ea8367a11@fastmail.fm>
Date:   Fri, 3 Mar 2023 20:19:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH 7/9] fuse: add fuse device ioctl(FUSE_DEV_IOC_REINIT)
Content-Language: en-US
To:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        mszeredi@redhat.com
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        =?UTF-8?Q?St=c3=a9phane_Graber?= <stgraber@ubuntu.com>,
        Seth Forshee <sforshee@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        criu@openvz.org
References: <20230220193754.470330-1-aleksandr.mikhalitsyn@canonical.com>
 <20230220193754.470330-8-aleksandr.mikhalitsyn@canonical.com>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <20230220193754.470330-8-aleksandr.mikhalitsyn@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2/20/23 20:37, Alexander Mikhalitsyn wrote:
> This ioctl aborts fuse connection and then reinitializes it,
> sends FUSE_INIT request to allow a new userspace daemon
> to pick up the fuse connection.
> 
> Cc: Miklos Szeredi <mszeredi@redhat.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: StÃ©phane Graber <stgraber@ubuntu.com>
> Cc: Seth Forshee <sforshee@kernel.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Andrei Vagin <avagin@gmail.com>
> Cc: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: criu@openvz.org
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---
>   fs/fuse/dev.c             | 132 ++++++++++++++++++++++++++++++++++++++
>   include/uapi/linux/fuse.h |   1 +
>   2 files changed, 133 insertions(+)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 737764c2295e..0f53ffd63957 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -2187,6 +2187,112 @@ void fuse_abort_conn(struct fuse_conn *fc)
>   }
>   EXPORT_SYMBOL_GPL(fuse_abort_conn);
>   
> +static int fuse_reinit_conn(struct fuse_conn *fc)
> +{
> +	struct fuse_iqueue *fiq = &fc->iq;
> +	struct fuse_dev *fud;
> +	unsigned int i;

Assuming you have a malicious daemon that tries to cause bad behavior, 
only allow one ioctl at at time? I.e. add a value that reinit is in 
progress? And unset at the end of the function?

> +
> +	if (fc->conn_gen + 1 < fc->conn_gen)
> +		return -EOVERFLOW;
> +

Add a comment, like

/* Unsets fc->connected and fiq->connected and ensures that no new 
requests can be queued */

?

> +	fuse_abort_conn(fc);
> +	fuse_wait_aborted(fc);
> +
> +	spin_lock(&fc->lock);
> +	if (fc->connected) {
> +		spin_unlock(&fc->lock);
> +		return -EINVAL;
> +	}
> +
> +	if (fc->conn_gen + 1 < fc->conn_gen) {
> +		spin_unlock(&fc->lock);
> +		return -EOVERFLOW;
> +	}
> +
> +	fc->conn_gen++;
> +
> +	spin_lock(&fiq->lock);
> +	if (request_pending(fiq) || fiq->forget_list_tail != &fiq->forget_list_head) {
> +		spin_unlock(&fiq->lock);
> +		spin_unlock(&fc->lock);
> +		return -EINVAL;
> +	}
> +
> +	if (&fuse_dev_fiq_ops != fiq->ops) {
> +		spin_unlock(&fiq->lock);
> +		spin_unlock(&fc->lock);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	fiq->connected = 1;
> +	spin_unlock(&fiq->lock);
> +
> +	spin_lock(&fc->bg_lock);
> +	if (!list_empty(&fc->bg_queue)) {
> +		spin_unlock(&fc->bg_lock);
> +		spin_unlock(&fc->lock);
> +		return -EINVAL;
> +	}
> +
> +	fc->blocked = 0;
> +	fc->max_background = FUSE_DEFAULT_MAX_BACKGROUND;
> +	spin_unlock(&fc->bg_lock);
> +
> +	list_for_each_entry(fud, &fc->devices, entry) {
> +		struct fuse_pqueue *fpq = &fud->pq;
> +
> +		spin_lock(&fpq->lock);
> +		if (!list_empty(&fpq->io)) {
> +			spin_unlock(&fpq->lock);
> +			spin_unlock(&fc->lock);
> +			return -EINVAL;
> +		}
> +
> +		for (i = 0; i < FUSE_PQ_HASH_SIZE; i++) {
> +			if (!list_empty(&fpq->processing[i])) {
> +				spin_unlock(&fpq->lock);
> +				spin_unlock(&fc->lock);
> +				return -EINVAL;
> +			}
> +		}
> +
> +		fpq->connected = 1;
> +		spin_unlock(&fpq->lock);
> +	}
> +
> +	fuse_set_initialized(fc);

I'm not sure about this, why not the common way via FUSE_INIT reply?

> +
> +	/* Background queuing checks fc->connected under bg_lock */
> +	spin_lock(&fc->bg_lock);
> +	fc->connected = 1;
> +	spin_unlock(&fc->bg_lock);
> +
> +	fc->aborted = false;
> +	fc->abort_err = 0;
> +
> +	/* nullify all the flags */
> +	memset(&fc->flags, 0, sizeof(struct fuse_conn_flags));
> +
> +	spin_unlock(&fc->lock);
> +
> +	down_read(&fc->killsb);
> +	if (!list_empty(&fc->mounts)) {
> +		struct fuse_mount *fm;
> +
> +		fm = list_first_entry(&fc->mounts, struct fuse_mount, fc_entry);
> +		if (!fm->sb) {
> +			up_read(&fc->killsb);
> +			return -EINVAL;
> +		}
> +
> +		fuse_send_init(fm);
> +	}
> +	up_read(&fc->killsb);
> +
> +	return 0;
> +}
> +
>   void fuse_wait_aborted(struct fuse_conn *fc)
>   {
>   	/* matches implicit memory barrier in fuse_drop_waiting() */
> @@ -2282,6 +2388,32 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
>   			}
>   		}
>   		break;
> +	case FUSE_DEV_IOC_REINIT:
> +		struct fuse_conn *fc;
> +
> +		if (!checkpoint_restore_ns_capable(file->f_cred->user_ns))
> +			return -EPERM;
> +
> +		res = -EINVAL;
> +		fud = fuse_get_dev(file);
> +
> +		/*
> +		 * Only fuse mounts with an already initialized fuse
> +		 * connection are supported
> +		 */
> +		if (file->f_op == &fuse_dev_operations && fud) {
> +			mutex_lock(&fuse_mutex);
> +			fc = fud->fc;
> +			if (fc)
> +				fc = fuse_conn_get(fc);
> +			mutex_unlock(&fuse_mutex);
> +
> +			if (fc) {
> +				res = fuse_reinit_conn(fc);
> +				fuse_conn_put(fc);
> +			}
> +		}
> +		break;
>   	default:
>   		res = -ENOTTY;
>   		break;
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 1b9d0dfae72d..3dac67b25eae 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -989,6 +989,7 @@ struct fuse_notify_retrieve_in {
>   /* Device ioctls: */
>   #define FUSE_DEV_IOC_MAGIC		229
>   #define FUSE_DEV_IOC_CLONE		_IOR(FUSE_DEV_IOC_MAGIC, 0, uint32_t)
> +#define FUSE_DEV_IOC_REINIT		_IO(FUSE_DEV_IOC_MAGIC, 0)
>   
>   struct fuse_lseek_in {
>   	uint64_t	fh;
