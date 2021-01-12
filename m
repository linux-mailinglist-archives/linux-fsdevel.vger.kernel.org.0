Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403012F393A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 19:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732012AbhALSu6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 13:50:58 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:45652 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbhALSu6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 13:50:58 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kzOkC-009ArJ-Ab; Tue, 12 Jan 2021 11:50:16 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kzOkB-005FSx-Em; Tue, 12 Jan 2021 11:50:15 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org, "Serge E. Hallyn" <serge@hallyn.com>,
        <linux-api@vger.kernel.org>
References: <20201207163255.564116-1-mszeredi@redhat.com>
        <20201207163255.564116-2-mszeredi@redhat.com>
        <87czyoimqz.fsf@x220.int.ebiederm.org>
        <20210111134916.GC1236412@miu.piliscsaba.redhat.com>
        <874kjnm2p2.fsf@x220.int.ebiederm.org>
        <CAJfpegtKMwTZwENX7hrVGUVRWgNTf4Tr_bRxYrPpPAH_D2fH-Q@mail.gmail.com>
        <87bldugfxx.fsf@x220.int.ebiederm.org>
Date:   Tue, 12 Jan 2021 12:49:12 -0600
In-Reply-To: <87bldugfxx.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 12 Jan 2021 12:36:58 -0600")
Message-ID: <87blduf0t3.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kzOkB-005FSx-Em;;;mid=<87blduf0t3.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19ju0OPFy9uih7pH63u6KWksVfbPTCfYQ0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Miklos Szeredi <miklos@szeredi.hu>
X-Spam-Relay-Country: 
X-Spam-Timing: total 317 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.9 (1.2%), b_tie_ro: 2.8 (0.9%), parse: 0.64
        (0.2%), extract_message_metadata: 8 (2.4%), get_uri_detail_list: 0.86
        (0.3%), tests_pri_-1000: 11 (3.3%), tests_pri_-950: 1.05 (0.3%),
        tests_pri_-900: 0.86 (0.3%), tests_pri_-90: 101 (31.9%), check_bayes:
        100 (31.5%), b_tokenize: 4.3 (1.4%), b_tok_get_all: 5 (1.7%),
        b_comp_prob: 1.31 (0.4%), b_tok_touch_all: 86 (27.2%), b_finish: 0.60
        (0.2%), tests_pri_0: 181 (57.1%), check_dkim_signature: 0.38 (0.1%),
        check_dkim_adsp: 2.1 (0.7%), poll_dns_idle: 0.77 (0.2%), tests_pri_10:
        1.70 (0.5%), tests_pri_500: 6 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 01/10] vfs: move cap_convert_nscap() call into vfs_setxattr()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> So there is the basic question do we want to read the raw bytes on disk
> or do we want to return something meaningful to the reader.  As the
> existing tools use the xattr interface to set/clear fscaps returning
> data to user space rather than raw bytes seems the perfered interface.
>
> My ideal semantics would be:
>
> - If current_user_ns() == sb->s_user_ns return the raw data.
>
>   I don't know how to implement this first scenario while permitting
>   stacked filesystems.

    After a little more thought I do.

    In getxattr if the get_cap method is not implemented by the
    filesystem if current_user_ns() == sb->s_user_ns simply treat it as
    an ordinary xattr read/write.

    Otherwise call vfs_get_cap and translate the result as described
    below.
    
    The key point of this is it allows for seeing what is actually on
    disk (when it is not confusing).

> - Calculate the cpu_vfs_cap_data as get_vfs_caps_from_disk does.
>   That gives the meaning of the xattr.
>
> - If "from_kuid(current_userns(), krootid) == 0" return a v2 cap.
>
> - If "rootid_owns_currentns()" return a v2 cap.
>
> - Else return an error.  Probably a permission error.
>
>   The fscap simply can not make sense to the user if the rootid does not
>   map.  Return a v2 cap would imply that the caps are present on the
>   executable (in the current context) which they are not.


Eric
