Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D175BCDAB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 15:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiISNwn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 09:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiISNwm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:52:42 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5F82BC2;
        Mon, 19 Sep 2022 06:52:40 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:33224)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oaHCQ-000UIg-7I; Mon, 19 Sep 2022 07:52:38 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:37536 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oaHCO-007Sl5-GG; Mon, 19 Sep 2022 07:52:37 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Jiangshan Yi <13667453960@163.com>
Cc:     viro@zeniv.linux.org.uk, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jiangshan Yi <yijiangshan@kylinos.cn>
References: <20220919025139.3623754-1-13667453960@163.com>
Date:   Mon, 19 Sep 2022 08:52:17 -0500
In-Reply-To: <20220919025139.3623754-1-13667453960@163.com> (Jiangshan Yi's
        message of "Mon, 19 Sep 2022 10:51:39 +0800")
Message-ID: <87pmfr5v5a.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oaHCO-007Sl5-GG;;;mid=<87pmfr5v5a.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+VZ4y/8q2TorQ6l/dySqXv0i95p+myx0w=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Jiangshan Yi <13667453960@163.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1173 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 5.0 (0.4%), b_tie_ro: 3.4 (0.3%), parse: 1.07
        (0.1%), extract_message_metadata: 11 (1.0%), get_uri_detail_list: 1.55
        (0.1%), tests_pri_-1000: 5 (0.4%), tests_pri_-950: 1.15 (0.1%),
        tests_pri_-900: 0.79 (0.1%), tests_pri_-90: 95 (8.1%), check_bayes: 93
        (7.9%), b_tokenize: 4.3 (0.4%), b_tok_get_all: 6 (0.5%), b_comp_prob:
        1.45 (0.1%), b_tok_touch_all: 78 (6.6%), b_finish: 0.79 (0.1%),
        tests_pri_0: 191 (16.3%), check_dkim_signature: 0.38 (0.0%),
        check_dkim_adsp: 2.5 (0.2%), poll_dns_idle: 837 (71.4%), tests_pri_10:
        2.4 (0.2%), tests_pri_500: 857 (73.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] fs/binfmt_flat.c: use __func__ instead of function name
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jiangshan Yi <13667453960@163.com> writes:

> From: Jiangshan Yi <yijiangshan@kylinos.cn>
>
> It is better to use __func__ instead of function name.

Why?

Usually we leave these kinds of stylistic decisions to the people
actually working on and maintaining the code.

Unless this message is likely to be copied to another function
and it very much does not look like it is, this kind of change
looks like it will just make grepping for the error message more
difficult.

Not that I am working on the code and can speak but this just feels like
a gratuitous change to me and so I am asking questions to make certain
it is actually worth making.

Eric


> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
> ---
>  fs/binfmt_flat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
> index c26545d71d39..4104c824e7b1 100644
> --- a/fs/binfmt_flat.c
> +++ b/fs/binfmt_flat.c
> @@ -184,7 +184,7 @@ static int decompress_exec(struct linux_binprm *bprm, loff_t fpos, char *dst,
>  	z_stream strm;
>  	int ret, retval;
>  
> -	pr_debug("decompress_exec(offset=%llx,buf=%p,len=%lx)\n", fpos, dst, len);
> +	pr_debug("%s(offset=%llx,buf=%p,len=%lx)\n", __func__, fpos, dst, len);
>  
>  	memset(&strm, 0, sizeof(strm));
>  	strm.workspace = kmalloc(zlib_inflate_workspacesize(), GFP_KERNEL);
