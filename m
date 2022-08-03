Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147AC588572
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Aug 2022 03:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235653AbiHCBc0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Aug 2022 21:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbiHCBcZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Aug 2022 21:32:25 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2040.outbound.protection.outlook.com [40.107.100.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1983A558FB;
        Tue,  2 Aug 2022 18:32:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYVEBmxMInNIzj4hkpzPykjVp7FmonD7iiQ8uzlj33eDBF0dSrie9xrByxFytKmPLd77uEhln2h8mmnTJXQuR2dQwofzidfMSBjrpU5L7bj3g0i/VmvdGL53FhowNj5k0ykrQ8yazvfEXnJ2w572cPcBVhZ1nnMVIIBWajwxmskxc840KNZURF+nL1WUISFiwovncs3BgrfWEDiMObz6JbSNJ/q5/7mnX78tasqaEp7bSk221KjOsaDOhRg7xzS3i5Z2r3b96m4F1NRhBoEhsM0sZ4AN6pUmq6zbRjDkHmU39EFJ6VCiedldhm4jNJacL1zIrwHSpqpz8Wuc3UemVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymEVl11ZiouGEvA56eOpZp3meSRb7d0ZdQdHzk39f3Y=;
 b=E83F1s021oFwHSRZIRdDa9HU+HXKW/A3r+2+PZwF42qfwoCbssV1wCFTl6iqq+qw6ose0CRAfpjB1IUA+Tw3cmXEYC7bBy1Sq0FmuqPrFwbDz0gVZfl+MbZVrHMBlv/f7ApxLwhK0wIOkXFoeQSvfiIcusGH3BTqsc+D7YKI1cOpue1g57aRxHkVk3Y/ViTu6RWZv3FgOTVWHxMBB0VxvQjXA93mZzOs0l0yFwzJpiqnzvGMHKBbOxCveNILAeccC6otbSdTMvgo/1+QivkTmMWdFWQXpxeD18ADcoi45lFL9Kw0CmsviY5EV8V09tY5m0RmHaAO6ryuMjga8DEtmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 MWHPR0101MB2928.prod.exchangelabs.com (2603:10b6:301:31::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.15; Wed, 3 Aug 2022 01:32:20 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::21e9:8dbb:6e40:5073]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::21e9:8dbb:6e40:5073%2]) with mapi id 15.20.5482.016; Wed, 3 Aug 2022
 01:32:20 +0000
Message-ID: <1c2e8880-3efe-b55d-ee50-87d57efc3130@talpey.com>
Date:   Tue, 2 Aug 2022 21:32:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [RFC PATCH 0/3] Rename "cifs" module to "smbfs"
To:     Jeff Layton <jlayton@kernel.org>,
        Enzo Matsumiya <ematsumiya@suse.de>
Cc:     linux-cifs@vger.kernel.org, smfrench@gmail.com, pc@cjr.nz,
        ronniesahlberg@gmail.com, nspmangalore@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        samba-technical@lists.samba.org, pshilovsky@samba.org
References: <20220801190933.27197-1-ematsumiya@suse.de>
 <c05f4fc668fa97e737758ab03030d7170c0edbd9.camel@kernel.org>
 <20220802193620.dyvt5qiszm2pobsr@cyberdelia>
 <6f3479265b446d180d71832fd0c12650b908ebe2.camel@kernel.org>
Content-Language: en-US
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <6f3479265b446d180d71832fd0c12650b908ebe2.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR14CA0007.namprd14.prod.outlook.com
 (2603:10b6:208:23e::12) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87ddc0e0-d0ba-47be-7ad3-08da74f00216
X-MS-TrafficTypeDiagnostic: MWHPR0101MB2928:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fLoZY8nZsBeAnmKwezQo/eFzsAKewcKzvtvCoobrerm2T1ueIT6Hj5Kda4NBUUoYkT+E0bsIF/yjWEkzy2uBiIvzRy3vX3n1gfcnl/WhgqUxeVw3LmMhjo27QVzqd8FIVL5b3SCGs49jUyPoHh+cSSKJ6vwdr6ifKkHlieSp/sIppoutVGSHTgD27Xh2SdYIuS3ZYHvD1apSMxyjc1+AM8C2KsC8k4X84WvCAdfI4VgAVouFCqXgfqHIfz1atasoBeneMf9NUbWoggQ8ZrVn3X975XLSBOydjxgx1f2A6EXXBO0E0Ii2dDKSJ90sJzL8D9/0uKvJiwUBqHupkANG+4Yv9NPn+BPxLK9u4ZjpgKZgGQ4C6fYMpihELC4FZAhTBUQbpqabXdbokFmlVzTx1cWVgReIyZRhZuGOizMmv+64+VdLtr/HsmdFanPn2Xoj1BvzNa411rct/7ZC9d8fCc+HspgMjpbgK1GMiBfjHfYWP1vTpQy7/2UhfvPHb8voTSKvNZoX3nX7HW4IRTVKfUpjbcm3wd5p/TcQmdB9p6CFk9pt6WdxF22HDTkFX495rKGW1rBi/+DhGefPOqgFXmWbniNv8S0MGFOZdYcaeJmKfF0bTDQvt4cVq83YF5zssi9ojcH3bk1ganL6aV7kx0ZfiAbnNjvnzdjzPqRJsTQEG8B7qKPXfnN+MxgdbylFPAFa5H8K71yHsQxvQMt+s8cCtuJ9rWXctIGrf1pcJdsS14UfzsTuHeOKXa9GX56a7fFacN062QSAff2fT5/PvWkaXfQMJc0Tyvlic6VoDmpsji9k4JZVYoYpZmxXr8rUlj/Ob3eFS3DfmUHM6qik725lI5FwRaqfMBImmrbAR1A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(39830400003)(376002)(366004)(136003)(478600001)(83380400001)(36756003)(31686004)(966005)(316002)(6486002)(186003)(31696002)(41300700001)(2906002)(110136005)(8936002)(2616005)(66946007)(66476007)(66556008)(86362001)(8676002)(4326008)(7416002)(6512007)(5660300002)(26005)(6506007)(53546011)(52116002)(38350700002)(38100700002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wmw1SWMxd2RQNlRiVTM2R05pSWU2Q09HQzQzRUhxcHpkUHBhYlNMYXgvcTFR?=
 =?utf-8?B?aWdVOU9TUTY2UWQyekNxV1FibDlwUHFtbW8rREVFMFE2YWhvaFpmZlNQVzJi?=
 =?utf-8?B?V202MENpK0laVXJKaHJzZGlPbW56MDlSalRlV2hIcmwwOSswNDFERGsrbzRY?=
 =?utf-8?B?VC9MYkxjaVZYNy9aSW85cFhucFlvNUFUZ3pPZS95WEJodVFhSUhpV2RHTkpm?=
 =?utf-8?B?dWdIcDFaejBSZlRiWkM3N3VNZmg3cHJVbEpPdmtLVUNkb1BZS1RZNWtHbGRL?=
 =?utf-8?B?SVVqM084OE1YbjJHbU1OT3NiNXJ1VkdyVVB5eURXWU41bWszc3RoSTRWa2hn?=
 =?utf-8?B?TFZVTW4wNGFPMDk4VHJwQlNLRzRxaHNRMzB3QUxGTVFqakduaW1xREJvSW1t?=
 =?utf-8?B?SmxrZU51MmZkeTgwK0huT2tFSXc0SG50UTdBM0xnejdOQXFNckVCYS8wck54?=
 =?utf-8?B?OTRHa3VUNHBCZ2ZKSm80K1VYa0JvYnRJRkNMaXA4RHNCOGdlZ0hZTTZUdE1X?=
 =?utf-8?B?LzFINGtHUHl5VnUwVy9ReTR4OXpaUTN3OUJXRCs2SkFuQzhsMjUzajJpWk5P?=
 =?utf-8?B?Q0pVendkbkJQRU43eHBOTkJsdlpYU1Ewb3pDZ3phT3lDek1hM3JNMGhhN2tZ?=
 =?utf-8?B?NVU1VnVyRlo4a212bWRZeG9ENFZmVnVkbUJwRG84WlZVQU1qNURXU292Vitq?=
 =?utf-8?B?a3M5RFV2bDZ0S0gyd0VwWXZwWUg3eGQzSGN4dWRiWEkrb1VXYVYrMXdZQ0Js?=
 =?utf-8?B?dUJVUVRuR0lFeFdsTzh3ellMMlBLS0JFOW5ZT1NNMGR1dXZqaUZMenM4RDNx?=
 =?utf-8?B?MURocUpDZFovZWtEOWF1bHdPNmc5S0RDZEpZRlg3eHZtVnhndFdEWlFMSjk0?=
 =?utf-8?B?VXI1aFFFRTB5VWdYMGVKWXBMdyt5RXVKR2VuOXBwenJMdFFPWkFydVUzbEpp?=
 =?utf-8?B?Z2h6czhHaWl5OTJFOWZMQVZNTzExd1ljRExZaWM3U1NnNDNyZVM0QXpVQWxV?=
 =?utf-8?B?NzR3VE95cDdZdHFoTjFZSlA1ZXFYb1ZreFVrdUlWUFNVMXlIYWhFcWNjcnJu?=
 =?utf-8?B?dHQrWnI5S0dLaGFydG5TSkcydllxVC9Wc0MxQmFFdDJXODFIRzV0ZHB3L0Nx?=
 =?utf-8?B?T2s5cFJod05IWnJLMFZhNE5kM0hubytTeFdhT0Y2Y1pCZXRhTjFUSksra2sy?=
 =?utf-8?B?OTlLRTU0VERBSG1EUVUwZ2F3enJOY3dudFBycXd5cFZ1UGh6UEx0a21YVDB5?=
 =?utf-8?B?a3l0YTVKZlVvNzFFd3lFZHRxQzRJK25UTlBFaTFENTlEd1hSN0lBMDF3d29n?=
 =?utf-8?B?QUc4cDVaRmJFUEl5TnNVMmR5R1ZhUmc3TTI3dUxua3l3ek14RVJXWnUrTnhI?=
 =?utf-8?B?cDY2b1pSNTBGOUNCQkNzUkdCUHlsRS82R1kxUnFvVGlQSTRuWW9Hc1krNGRo?=
 =?utf-8?B?cGIyYUFnd1J2bkZPbTZjalhrMG5GalFhZ0FtNnJXTHJnYmxydiswblNQNHhD?=
 =?utf-8?B?eTAwL2YveXg3V2Y5ZGU2NGU4WmRRZDJtNTA1OWtQdm9HZXdyVWttUG1EMWh2?=
 =?utf-8?B?c1NJVkhReTNnd0dlRUh4UmZoRlZ3ZG9oVFArRWxwVmR5cEhlZTRqcHhFWU1P?=
 =?utf-8?B?cW9VaVhXWVk0YmppUnVDcUZCZXJGVlRGN2JvUUdxZENXM3YycktLeHUvS2dn?=
 =?utf-8?B?ckt1bGhkdWVaT0t3NWJ5R2V4M0VrRGpIeGVyNEs0eUZ3Vmw4NXMyWTFQRjBJ?=
 =?utf-8?B?OW1Wa2J2WCsveEo1MHhPNTlBODAvcUVvbzhzakVSbWZzZkpPL2hQQ1NyeGwv?=
 =?utf-8?B?eDRGUTU5SnVtY2lySitZRzhwdzFqTkozMFVoTmpoVDlQeVRQUlphSnhIY2Yv?=
 =?utf-8?B?YnZabnc5NHl0WG5ERlR3QlZuK3d0SDF5b2V0YUlnLzRhWTgvK3FXbCtqaEZD?=
 =?utf-8?B?VjlNZlhWV0pPRXU5ODR3MURiN3N6MEIvN1VXQlIvUDF0VlEyL0gyYVdqUmFx?=
 =?utf-8?B?ZXVCYjVLaVloa3N6NG1ha2txbUZRSmF2NDRaU3R5UTVNaWxyZ3dXUVZBRi9F?=
 =?utf-8?B?aEs2bk1YMzhIYWlXTmkzZjUyWDlxajNnRmJqdmxqa01wOTB5WG1HMC9Oc2NG?=
 =?utf-8?Q?Ikv0=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ddc0e0-d0ba-47be-7ad3-08da74f00216
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 01:32:20.5159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iU7BuPrCffAmfDhhvdlkhAS22EbEgNnkdVCrauJDwVvGIp+FDPW/Gdywhk0TYTiL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0101MB2928
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/2/2022 4:07 PM, Jeff Layton wrote:
> On Tue, 2022-08-02 at 16:36 -0300, Enzo Matsumiya wrote:
>> On 08/02, Jeff Layton wrote:
>>> On Mon, 2022-08-01 at 16:09 -0300, Enzo Matsumiya wrote:
>>>> Hi,
>>>>
>>>> As part of the ongoing effort to remove the "cifs" nomenclature from the
>>>> Linux SMB client, I'm proposing the rename of the module to "smbfs".
>>>>
>>>> As it's widely known, CIFS is associated to SMB1.0, which, in turn, is
>>>> associated with the security issues it presented in the past. Using
>>>> "SMBFS" makes clear what's the protocol in use for outsiders, but also
>>>> unties it from any particular protocol version. It also fits in the
>>>> already existing "fs/smbfs_common" and "fs/ksmbd" naming scheme.
>>>>
>>>> This short patch series only changes directory names and includes/ifdefs in
>>>> headers and source code, and updates docs to reflect the rename. Other
>>>> than that, no source code/functionality is modified (WIP though).
>>>>
>>>> Patch 1/3: effectively changes the module name to "smbfs" and create a
>>>> 	   "cifs" module alias to maintain compatibility (a warning
>>>> 	   should be added to indicate the complete removal/isolation of
>>>> 	   CIFS/SMB1.0 code).
>>>> Patch 2/3: rename the source-code directory to align with the new module
>>>> 	   name
>>>> Patch 3/3: update documentation references to "fs/cifs" or "cifs.ko" or
>>>> 	   "cifs module" to use the new name
>>>>
>>>> Enzo Matsumiya (3):
>>>>    cifs: change module name to "smbfs.ko"
>>>>    smbfs: rename directory "fs/cifs" -> "fs/smbfs"
>>>>    smbfs: update doc references
>>>> ...
>>>
>>> Why do this? My inclination is to say NAK here.
>>>
>>> This seems like a lot of change for not a lot of benefit. Renaming the
>>> directory like this pretty much guarantees that backporting patches
>>> after this change to kernels that existed before it will be very
>>> difficult.
>>
>> Hi Jeff, yes that's a big concern that I've discussed internally with my
>> team as well, since we'll also suffer from those future backports.
>>
>> But, as stated in the commit message, and from what I gathered from
>> Steve, it has been an ongoing wish to have the "cifs" name no longer
>> associated with a module handling SMB2.0 and SMB3.0, as the name brings
>> back old bad memories for several users.
>>
>> There really is no functional benefit for this change, and I have no
>> argument against that.
>>
> 
> If the concern is "branding" then I don't see how this really helps.
> Very few users interact with the kernel modules directly.
> 
> FWIW, I just called "modprobe smb3" on my workstation and got this:
> 
> [ 1223.581583] Key type cifs.spnego registered
> [ 1223.582523] Key type cifs.idmap registered
> [ 1230.411422] Key type cifs.idmap unregistered
> [ 1230.412542] Key type cifs.spnego unregistered
> 
> Are you going to rename the keyrings too? That will have implications
> for userland helper programs like cifs.upcall. There's also
> /proc/fs/cifs/*.
> 
> These are a "stable interfaces" that you can't just rename at will. If
> you want to change these interfaces then you need to do a formal
> deprecation announcement, and probably a period with /proc/fs/smbfs and
> /proc/fs/cifs coexisting.
> 
> There are also a ton of printk's and such that have "CIFS" in them that
> will need to be changed.
> 
> These costs do not seem worth the perceived benefit to me. You could
> probably hide a lot of what users see by just renaming (or symlinking)
> mount.cifs to mount.smb3.
> 
> I think if you guys are serious about this, you should probably start
> somewhere else besides renaming the directory and module. This is going
> to impact developers (and people who make their living doing backports)
> far more than it will users.

The initial goal is to modularize the SMB1 code, so it can be completely
removed from a running system. The extensive refactoring logically leads
to this directory renaming, but renaming is basically a side effect.

Stamping out the four-letter word C-I-F-S is a secondary goal. At this
point, the industry has stopped using it. You make a good point that
it's still visible outside the kernel source though.

It makes good sense to do the refactoring in place, at first. Splitting
the {smb1,cifs}*.[ch] files will be more complex, but maybe easier to
review and merge, without folding in a new directory tree and git rm/mv.
Either way, there will be at least two modules, maybe three if we split
out generic subroutines.

Enzo, you're up to your elbows in this code now, is it too ugly without
the new directories?

Tom.


>>> Also, bear in mind that there used to be an smbfs in the kernel that
>>> predated cifs.ko. That was removed ~2010 though, which is long enough
>>> ago that it shouldn't produce conflicts in currently shipping releases.
>>
>> Yes, I was aware of this before sending v1, and it got raised again in
>> https://lore.kernel.org/all/20220802135201.4vm36drd5mp57nvv@cyberdelia/
>>
>> I have no experience on what kind of issues/problems could arise of
>> that, aside from the git commit history being weird. If you ever seen
>> any problems with that happening, please do share.
>>
> 
> I doubt it'd be a problem in practice. If we hadn't ripped out smbfs so
> long ago I'd be more concerned, but that's pretty much ancient history
> now.
> 
>>
>> I sent a v2 with a new "fs/smb" directory name, but kept "smbfs" as the
>> module name.
>>
> 
> That's a little nicer, but really the problem is the "big rename"
> itself.
> 
>> Sorry I didn't reply to you before that, I got confused as the thread
>> replies all went to different folders in my mailbox.
>>
> 
> No worries.
