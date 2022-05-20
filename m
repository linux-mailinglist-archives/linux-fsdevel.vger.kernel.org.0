Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C1952F3A0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 21:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238298AbiETTEM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 May 2022 15:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238016AbiETTEL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 May 2022 15:04:11 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79323197F4A
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 May 2022 12:04:10 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:40898)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ns7uz-007P6t-8T; Fri, 20 May 2022 13:04:09 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:38890 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ns7uy-00BJgy-FH; Fri, 20 May 2022 13:04:08 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
References: <YocIMkS1qcPGrik0@zeniv-ca.linux.org.uk>
        <YocIiPQjR7tuYdkP@zeniv-ca.linux.org.uk>
        <YocI5jIou18bDDuy@zeniv-ca.linux.org.uk>
        <YocJDUARbpklMJgo@zeniv-ca.linux.org.uk>
        <YocJbOh4O/2efVjM@zeniv-ca.linux.org.uk>
        <YocJqCkNoTaehfYL@zeniv-ca.linux.org.uk>
Date:   Fri, 20 May 2022 14:02:52 -0500
In-Reply-To: <YocJqCkNoTaehfYL@zeniv-ca.linux.org.uk> (Al Viro's message of
        "Fri, 20 May 2022 03:23:20 +0000")
Message-ID: <87sfp410yr.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ns7uy-00BJgy-FH;;;mid=<87sfp410yr.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19hUt5PX5r2PctvKeDUOFTcDRpufrY4wtY=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Al Viro <viro@zeniv.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 247 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.7 (1.5%), b_tie_ro: 2.6 (1.0%), parse: 0.63
        (0.3%), extract_message_metadata: 11 (4.3%), get_uri_detail_list: 0.80
        (0.3%), tests_pri_-1000: 15 (6.2%), tests_pri_-950: 1.08 (0.4%),
        tests_pri_-900: 0.80 (0.3%), tests_pri_-90: 56 (22.7%), check_bayes:
        55 (22.3%), b_tokenize: 4.0 (1.6%), b_tok_get_all: 4.9 (2.0%),
        b_comp_prob: 1.23 (0.5%), b_tok_touch_all: 42 (17.2%), b_finish: 0.64
        (0.3%), tests_pri_0: 148 (59.9%), check_dkim_signature: 0.59 (0.2%),
        check_dkim_adsp: 2.4 (1.0%), poll_dns_idle: 0.99 (0.4%), tests_pri_10:
        1.73 (0.7%), tests_pri_500: 7 (2.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] blob_to_mnt(): kern_unmount() is needed to undo
 kern_mount()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> plain mntput() won't do.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Reviewed-by: "Eric W. Biederman" <ebiederm@xmission.com>

It is already performing kern_unmount on the happy path
so I don't see how it will be a problem to call kern_unmount
on a failure path.

Do you want to merge this through your tree?

>  kernel/usermode_driver.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/usermode_driver.c b/kernel/usermode_driver.c
> index 9dae1f648713..8303f4c7ca71 100644
> --- a/kernel/usermode_driver.c
> +++ b/kernel/usermode_driver.c
> @@ -28,7 +28,7 @@ static struct vfsmount *blob_to_mnt(const void *data, size_t len, const char *na
>  
>  	file = file_open_root_mnt(mnt, name, O_CREAT | O_WRONLY, 0700);
>  	if (IS_ERR(file)) {
> -		mntput(mnt);
> +		kern_unmount(mnt);
>  		return ERR_CAST(file);
>  	}
>  
> @@ -38,7 +38,7 @@ static struct vfsmount *blob_to_mnt(const void *data, size_t len, const char *na
>  		if (err >= 0)
>  			err = -ENOMEM;
>  		filp_close(file, NULL);
> -		mntput(mnt);
> +		kern_unmount(mnt);
>  		return ERR_PTR(err);
>  	}
