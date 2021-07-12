Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BABF3C63B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 21:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236249AbhGLTaH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 15:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236190AbhGLTaG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 15:30:06 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20382C0613DD;
        Mon, 12 Jul 2021 12:27:16 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r11so21872641wro.9;
        Mon, 12 Jul 2021 12:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KeQt73O3VXbfqdlM8EsBq9NtPQpTs/6ziHoXHq4rzJM=;
        b=rzI1K02hyVSUIVCycQePR82p3C9PZZBfw+wtJ0R4z+yiNUq4v1DOhtfQSh4Q9VJQ9f
         ZvcYE858jUbcqqR8UaCNzverlVnqbGVe+2LWF6yKtm3wGp8Gj7lOb7pg2W0dK0+9BkFO
         PuMUC0vxvmL5gsvuq4dCzI2ukioVMhY32SH4WW055fEcmA/obcUw+I0KUM9+IWO6yrlb
         t4ec0uTMiGAwC49xj5PgE3OM/09RKR2o9eZm38ahTyMXSAiDEHJqCNPFc9qt53TjIAFa
         ZQccrZj1jvsCek59U7Y95HDM7KMd1gNpPmTXBa+HZcfn58abzlbEeO7g+kpp5bLGfpRz
         pdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KeQt73O3VXbfqdlM8EsBq9NtPQpTs/6ziHoXHq4rzJM=;
        b=XPYraoRPm+fU+MMITlPB+3UKBzukLcRUlIReGrr0fpqWV4ErnGIDNPqf1QOptLdTE+
         6AUER57p/0itARzXI2q/53tCTmHhMuiBKQwYdZbgmPIh5jyGQ7IzDnWpzyefvy5ipyFq
         sfsL+fUK/4uC+bWagpJLUIe4t54rcSZrU9pJWQg3FUtCrxjZ26YBIa5J82WqXObPHyvx
         yObjUDW89vyIPj5WZaX4WB9CngMIR3pE+hBoJnmVJD5l5LLUSmseBOcejtLIusTsFi5f
         4hAor2QgeCRf0G6OVFdgSQb6uT3I1UEYG2TPaCTVb7AfYn1LmAxVs+NyafbNNZM1rg6F
         oYww==
X-Gm-Message-State: AOAM531Ob6++g7y70HFN63ji9X/21xMdb51kY3Osj5E/uX+AuNsgQSKU
        jjoTnN3gc/yWt8QQbdCtgCU4tZRyfElk0WCzmKw=
X-Google-Smtp-Source: ABdhPJxzXgN6PZ5+rRefURGC3bO+IpQg4KjJT5nLqMBwzJuExxcZdMOBtc6mki036n1avg8nvnne0OOx7w3r3DnB79s=
X-Received: by 2002:a5d:6caf:: with SMTP id a15mr662342wra.313.1626118034752;
 Mon, 12 Jul 2021 12:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <162610726011.3408253.2771348573083023654.stgit@warthog.procyon.org.uk>
 <162610726860.3408253.445207609466288531.stgit@warthog.procyon.org.uk>
In-Reply-To: <162610726860.3408253.445207609466288531.stgit@warthog.procyon.org.uk>
From:   Marc Dionne <marc.c.dionne@gmail.com>
Date:   Mon, 12 Jul 2021 16:27:03 -0300
Message-ID: <CAB9dFdt5P-6nB0D_nMb-PT+Uv+FtAy811PA_W2fXPZAvPRo0sQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] afs: Fix tracepoint string placement with built-in AFS
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org,
        "Alexey Dobriyan (SK hynix)" <adobriyan@gmail.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 12, 2021 at 1:28 PM David Howells <dhowells@redhat.com> wrote:
>
> To quote Alexey[1]:
>
>     I was adding custom tracepoint to the kernel, grabbed full F34 kernel
>     .config, disabled modules and booted whole shebang as VM kernel.
>
>     Then did
>
>         perf record -a -e ...
>
>     It crashed:
>
>         general protection fault, probably for non-canonical address 0x435f5346592e4243: 0000 [#1] SMP PTI
>         CPU: 1 PID: 842 Comm: cat Not tainted 5.12.6+ #26
>         Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-1.fc33 04/01/2014
>         RIP: 0010:t_show+0x22/0xd0
>
>     Then reproducer was narrowed to
>
>         # cat /sys/kernel/tracing/printk_formats
>
>     Original F34 kernel with modules didn't crash.
>
>     So I started to disable options and after disabling AFS everything
>     started working again.
>
>     The root cause is that AFS was placing char arrays content into a
>     section full of _pointers_ to strings with predictable consequences.
>
>     Non canonical address 435f5346592e4243 is "CB.YFS_" which came from
>     CM_NAME macro.
>
>     Steps to reproduce:
>
>         CONFIG_AFS=y
>         CONFIG_TRACING=y
>
>         # cat /sys/kernel/tracing/printk_formats
>
> Fix this by the following means:
>
>  (1) Add enum->string translation tables in the event header with the AFS
>      and YFS cache/callback manager operations listed by RPC operation ID.
>
>  (2) Modify the afs_cb_call tracepoint to print the string from the
>      translation table rather than using the string at the afs_call name
>      pointer.
>
>  (3) Switch translation table depending on the service we're being accessed
>      as (AFS or YFS) in the tracepoint print clause.  Will this cause
>      problems to userspace utilities?
>
>      Note that the symbolic representation of the YFS service ID isn't
>      available to this header, so I've put it in as a number.  I'm not sure
>      if this is the best way to do this.
>
>  (4) Remove the name wrangling (CM_NAME) macro and put the names directly
>      into the afs_call_type structs in cmservice.c.
>
> Fixes: 8e8d7f13b6d5a9 ("afs: Add some tracepoints")
> Reported-by: Alexey Dobriyan (SK hynix) <adobriyan@gmail.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> cc: Andrew Morton <akpm@linux-foundation.org>
> cc: linux-afs@lists.infradead.org
> Link: https://lore.kernel.org/r/YLAXfvZ+rObEOdc%2F@localhost.localdomain/ [1]
> Link: https://lore.kernel.org/r/643721.1623754699@warthog.procyon.org.uk/
> Link: https://lore.kernel.org/r/162430903582.2896199.6098150063997983353.stgit@warthog.procyon.org.uk/ # v1
> Link: https://lore.kernel.org/r/162609463957.3133237.15916579353149746363.stgit@warthog.procyon.org.uk/ # v1 (repost)
> ---
>
>  fs/afs/cmservice.c         |   25 +++++-----------
>  include/trace/events/afs.h |   67 +++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 69 insertions(+), 23 deletions(-)
>
> diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
> index d3c6bb22c5f4..a3f5de28be79 100644
> --- a/fs/afs/cmservice.c
> +++ b/fs/afs/cmservice.c
> @@ -29,16 +29,11 @@ static void SRXAFSCB_TellMeAboutYourself(struct work_struct *);
>
>  static int afs_deliver_yfs_cb_callback(struct afs_call *);
>
> -#define CM_NAME(name) \
> -       char afs_SRXCB##name##_name[] __tracepoint_string =     \
> -               "CB." #name
> -
>  /*
>   * CB.CallBack operation type
>   */
> -static CM_NAME(CallBack);
>  static const struct afs_call_type afs_SRXCBCallBack = {
> -       .name           = afs_SRXCBCallBack_name,
> +       .name           = "CB.CallBack",
>         .deliver        = afs_deliver_cb_callback,
>         .destructor     = afs_cm_destructor,
>         .work           = SRXAFSCB_CallBack,
> @@ -47,9 +42,8 @@ static const struct afs_call_type afs_SRXCBCallBack = {
>  /*
>   * CB.InitCallBackState operation type
>   */
> -static CM_NAME(InitCallBackState);
>  static const struct afs_call_type afs_SRXCBInitCallBackState = {
> -       .name           = afs_SRXCBInitCallBackState_name,
> +       .name           = "CB.InitCallBackState",
>         .deliver        = afs_deliver_cb_init_call_back_state,
>         .destructor     = afs_cm_destructor,
>         .work           = SRXAFSCB_InitCallBackState,
> @@ -58,9 +52,8 @@ static const struct afs_call_type afs_SRXCBInitCallBackState = {
>  /*
>   * CB.InitCallBackState3 operation type
>   */
> -static CM_NAME(InitCallBackState3);
>  static const struct afs_call_type afs_SRXCBInitCallBackState3 = {
> -       .name           = afs_SRXCBInitCallBackState3_name,
> +       .name           = "CB.InitCallBackState3",
>         .deliver        = afs_deliver_cb_init_call_back_state3,
>         .destructor     = afs_cm_destructor,
>         .work           = SRXAFSCB_InitCallBackState,
> @@ -69,9 +62,8 @@ static const struct afs_call_type afs_SRXCBInitCallBackState3 = {
>  /*
>   * CB.Probe operation type
>   */
> -static CM_NAME(Probe);
>  static const struct afs_call_type afs_SRXCBProbe = {
> -       .name           = afs_SRXCBProbe_name,
> +       .name           = "CB.Probe",
>         .deliver        = afs_deliver_cb_probe,
>         .destructor     = afs_cm_destructor,
>         .work           = SRXAFSCB_Probe,
> @@ -80,9 +72,8 @@ static const struct afs_call_type afs_SRXCBProbe = {
>  /*
>   * CB.ProbeUuid operation type
>   */
> -static CM_NAME(ProbeUuid);
>  static const struct afs_call_type afs_SRXCBProbeUuid = {
> -       .name           = afs_SRXCBProbeUuid_name,
> +       .name           = "CB.ProbeUuid",
>         .deliver        = afs_deliver_cb_probe_uuid,
>         .destructor     = afs_cm_destructor,
>         .work           = SRXAFSCB_ProbeUuid,
> @@ -91,9 +82,8 @@ static const struct afs_call_type afs_SRXCBProbeUuid = {
>  /*
>   * CB.TellMeAboutYourself operation type
>   */
> -static CM_NAME(TellMeAboutYourself);
>  static const struct afs_call_type afs_SRXCBTellMeAboutYourself = {
> -       .name           = afs_SRXCBTellMeAboutYourself_name,
> +       .name           = "CB.TellMeAboutYourself",
>         .deliver        = afs_deliver_cb_tell_me_about_yourself,
>         .destructor     = afs_cm_destructor,
>         .work           = SRXAFSCB_TellMeAboutYourself,
> @@ -102,9 +92,8 @@ static const struct afs_call_type afs_SRXCBTellMeAboutYourself = {
>  /*
>   * YFS CB.CallBack operation type
>   */
> -static CM_NAME(YFS_CallBack);
>  static const struct afs_call_type afs_SRXYFSCB_CallBack = {
> -       .name           = afs_SRXCBYFS_CallBack_name,
> +       .name           = "YFSCB.CallBack",
>         .deliver        = afs_deliver_yfs_cb_callback,
>         .destructor     = afs_cm_destructor,
>         .work           = SRXAFSCB_CallBack,
> diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
> index 3ccf591b2374..9f73ed2cf061 100644
> --- a/include/trace/events/afs.h
> +++ b/include/trace/events/afs.h
> @@ -174,6 +174,34 @@ enum afs_vl_operation {
>         afs_VL_GetCapabilities  = 65537,        /* AFS Get VL server capabilities */
>  };
>
> +enum afs_cm_operation {
> +       afs_CB_CallBack                 = 204,  /* AFS break callback promises */
> +       afs_CB_InitCallBackState        = 205,  /* AFS initialise callback state */
> +       afs_CB_Probe                    = 206,  /* AFS probe client */
> +       afs_CB_GetLock                  = 207,  /* AFS get contents of CM lock table */
> +       afs_CB_GetCE                    = 208,  /* AFS get cache file description */
> +       afs_CB_GetXStatsVersion         = 209,  /* AFS get version of extended statistics */
> +       afs_CB_GetXStats                = 210,  /* AFS get contents of extended statistics data */
> +       afs_CB_InitCallBackState3       = 213,  /* AFS initialise callback state, version 3 */
> +       afs_CB_ProbeUuid                = 214,  /* AFS check the client hasn't rebooted */
> +};
> +
> +enum yfs_cm_operation {
> +       yfs_CB_Probe                    = 206,  /* YFS probe client */
> +       yfs_CB_GetLock                  = 207,  /* YFS get contents of CM lock table */
> +       yfs_CB_XStatsVersion            = 209,  /* YFS get version of extended statistics */
> +       yfs_CB_GetXStats                = 210,  /* YFS get contents of extended statistics data */
> +       yfs_CB_InitCallBackState3       = 213,  /* YFS initialise callback state, version 3 */
> +       yfs_CB_ProbeUuid                = 214,  /* YFS check the client hasn't rebooted */
> +       yfs_CB_GetServerPrefs           = 215,
> +       yfs_CB_GetCellServDV            = 216,
> +       yfs_CB_GetLocalCell             = 217,
> +       yfs_CB_GetCacheConfig           = 218,
> +       yfs_CB_GetCellByNum             = 65537,
> +       yfs_CB_TellMeAboutYourself      = 65538, /* get client capabilities */
> +       yfs_CB_CallBack                 = 64204,
> +};
> +
>  enum afs_edit_dir_op {
>         afs_edit_dir_create,
>         afs_edit_dir_create_error,
> @@ -436,6 +464,32 @@ enum afs_cb_break_reason {
>         EM(afs_YFSVL_GetCellName,               "YFSVL.GetCellName") \
>         E_(afs_VL_GetCapabilities,              "VL.GetCapabilities")
>
> +#define afs_cm_operations \
> +       EM(afs_CB_CallBack,                     "CB.CallBack") \
> +       EM(afs_CB_InitCallBackState,            "CB.InitCallBackState") \
> +       EM(afs_CB_Probe,                        "CB.Probe") \
> +       EM(afs_CB_GetLock,                      "CB.GetLock") \
> +       EM(afs_CB_GetCE,                        "CB.GetCE") \
> +       EM(afs_CB_GetXStatsVersion,             "CB.GetXStatsVersion") \
> +       EM(afs_CB_GetXStats,                    "CB.GetXStats") \
> +       EM(afs_CB_InitCallBackState3,           "CB.InitCallBackState3") \
> +       E_(afs_CB_ProbeUuid,                    "CB.ProbeUuid")
> +
> +#define yfs_cm_operations \
> +       EM(yfs_CB_Probe,                        "YFSCB.Probe") \
> +       EM(yfs_CB_GetLock,                      "YFSCB.GetLock") \
> +       EM(yfs_CB_XStatsVersion,                "YFSCB.XStatsVersion") \
> +       EM(yfs_CB_GetXStats,                    "YFSCB.GetXStats") \
> +       EM(yfs_CB_InitCallBackState3,           "YFSCB.InitCallBackState3") \
> +       EM(yfs_CB_ProbeUuid,                    "YFSCB.ProbeUuid") \
> +       EM(yfs_CB_GetServerPrefs,               "YFSCB.GetServerPrefs") \
> +       EM(yfs_CB_GetCellServDV,                "YFSCB.GetCellServDV") \
> +       EM(yfs_CB_GetLocalCell,                 "YFSCB.GetLocalCell") \
> +       EM(yfs_CB_GetCacheConfig,               "YFSCB.GetCacheConfig") \
> +       EM(yfs_CB_GetCellByNum,                 "YFSCB.GetCellByNum") \
> +       EM(yfs_CB_TellMeAboutYourself,          "YFSCB.TellMeAboutYourself") \
> +       E_(yfs_CB_CallBack,                     "YFSCB.CallBack")
> +
>  #define afs_edit_dir_ops                                 \
>         EM(afs_edit_dir_create,                 "create") \
>         EM(afs_edit_dir_create_error,           "c_fail") \
> @@ -569,6 +623,8 @@ afs_server_traces;
>  afs_cell_traces;
>  afs_fs_operations;
>  afs_vl_operations;
> +afs_cm_operations;
> +yfs_cm_operations;
>  afs_edit_dir_ops;
>  afs_edit_dir_reasons;
>  afs_eproto_causes;
> @@ -649,20 +705,21 @@ TRACE_EVENT(afs_cb_call,
>
>             TP_STRUCT__entry(
>                     __field(unsigned int,               call            )
> -                   __field(const char *,               name            )
>                     __field(u32,                        op              )
> +                   __field(u16,                        service_id      )
>                              ),
>
>             TP_fast_assign(
>                     __entry->call       = call->debug_id;
> -                   __entry->name       = call->type->name;
>                     __entry->op         = call->operation_ID;
> +                   __entry->service_id = call->service_id;
>                            ),
>
> -           TP_printk("c=%08x %s o=%u",
> +           TP_printk("c=%08x %s",
>                       __entry->call,
> -                     __entry->name,
> -                     __entry->op)
> +                     __entry->service_id == 2501 ?
> +                     __print_symbolic(__entry->op, yfs_cm_operations) :
> +                     __print_symbolic(__entry->op, afs_cm_operations))
>             );
>
>  TRACE_EVENT(afs_call,
>
>

Reviewed-by: Marc Dionne <marc.dionne@auristor.com>

If you wanted to avoid having the hard coded yfs service ID there, you
could pass in a boolean "is yfs" value and let the caller set it based
on the service ID, or even have two separate trace events.  But seems
fine as is.

Marc
